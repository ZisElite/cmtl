extends Control

signal new_pressed

var text_field
var confirm
var cancel

func _ready():
	text_field = get_node("ScrollContainer/HBoxContainer/VBoxContainer/name")
	confirm = get_node("ScrollContainer/HBoxContainer/VBoxContainer/HBoxContainer/confirm")
	cancel = get_node("ScrollContainer/HBoxContainer/VBoxContainer/HBoxContainer/cancel")
	confirm.pressed.connect(self._confirm)
	new_pressed.connect(get_parent()._check_new)
	cancel.pressed.connect(get_parent()._main_menu)
	visibility_changed.connect(self._clear_text)

func _confirm():
	new_pressed.emit(text_field.text)

func _clear_text():
	text_field.text = ""
