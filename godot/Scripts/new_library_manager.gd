extends Control

signal new_pressed

var text_field
var confirm
var cancel
var message
var sqlite
var logger

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
		update_message("Plese provide a name for the new library")
		return
	if !sqlite.check_new(text_field.text):
		update_message("There is already a library with this name.")
		return
	if !sqlite.create_new_library(text_field.text):
		update_message("There was an error during the creation of the library.\n
		Please check the logs and contact the creator.")
		return
	new_pressed.emit(text_field.text)

func _clear_text():
	text_field.text = ""
	message.text = ""
	
func update_message(text):
	message.text = text
