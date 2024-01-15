extends Control


var confirm
var cancel

func _ready():
	confirm = get_node("ScrollContainer/HBoxContainer/VBoxContainer/HBoxContainer/confirm")
	cancel = get_node("ScrollContainer/HBoxContainer/VBoxContainer/HBoxContainer/cancel")
	#confirm.pressed.connect()
	cancel.pressed.connect(get_parent()._main_menu)
