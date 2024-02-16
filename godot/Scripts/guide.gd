extends Control

var back

func _ready():
	back = get_node("ScrollContainer/VBoxContainer/back")
	back.pressed.connect(get_parent()._main_menu)
	visibility_changed.connect(self._reset)
	
func _reset():
	get_node("ScrollContainer/VBoxContainer/ScrollContainer").scroll_vertical = 0
