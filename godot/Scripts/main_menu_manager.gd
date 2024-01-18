extends Control

var new_lib
var open_lib
var exit

func _ready():
	new_lib = get_node("ScrollContainer/HBoxContainer/VBoxContainer/new")
	open_lib = get_node("ScrollContainer/HBoxContainer/VBoxContainer/open")
	exit = get_node("ScrollContainer/HBoxContainer/VBoxContainer/exit")
	new_lib.pressed.connect(get_parent()._new_library)
	open_lib.pressed.connect(get_parent()._open_library)
	exit.pressed.connect(self._exit)
	
func _exit():
	get_tree().quit()
