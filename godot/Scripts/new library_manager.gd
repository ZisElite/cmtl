extends Control

signal new_pressed
signal transition_to_new

var text_field
var confirm
var cancel

func _ready():
	text_field = get_node("ScrollContainer/HBoxContainer/VBoxContainer/name")
	confirm = get_node("ScrollContainer/HBoxContainer/VBoxContainer/HBoxContainer/confirm")
	cancel = get_node("ScrollContainer/HBoxContainer/VBoxContainer/HBoxContainer/cancel")
	transition_to_new.connect(get_parent()._view_library)
	confirm.pressed.connect(self._confirm)
	new_pressed.connect(get_parent()._check_new)
	cancel.pressed.connect(get_parent()._main_menu)

func _confirm():
	new_pressed.emit(text_field.text)
	
func _confirm_new(result):
	if result:
		#make database
		transition_to_new.emit()
