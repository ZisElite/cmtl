extends Control

signal new_pressed

var text_field
var confirm
var cancel
var message
var sqlite

func _ready():
	text_field = get_node("HBoxContainer/VBoxContainer/name")
	confirm = get_node("HBoxContainer/VBoxContainer/HBoxContainer/confirm")
	cancel = get_node("HBoxContainer/VBoxContainer/HBoxContainer/cancel")
	message = get_node("HBoxContainer/VBoxContainer/message")
	sqlite = get_parent().get_node("SQLite manager")
	message.text = ""
	confirm.pressed.connect(self._confirm)
	new_pressed.connect(get_parent()._prepare_new)
	cancel.pressed.connect(get_parent()._main_menu)
	visibility_changed.connect(self._clear_text)

func _confirm():
	if !text_field.text:
		print(str(float(Time.get_ticks_msec()) / 1000) + "s: No name was provided for the mew library.")
		message.text = "Plese provide a name for the new library"
		return
	if !sqlite.check_new(text_field.text):
		print(str(float(Time.get_ticks_msec()) / 1000) + "s: The provided library already exists.")
		message.text = "There is already a library with this name."
		return
	if !sqlite.create_new_library(text_field.text):
		print(str(float(Time.get_ticks_msec()) / 1000) + "s: Error with creating new library.")
		message.text = "There was an error during the creation of the library.\n
		Please check the logs and contact the creator."
		return
	print(str(float(Time.get_ticks_msec()) / 1000) + "s: New library succesfully created.")
	new_pressed.emit(text_field.text)

func _clear_text():
	text_field.text = ""
	message.text = ""
