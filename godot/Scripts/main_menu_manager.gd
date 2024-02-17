extends Control

var new_lib
var open_lib
var guide
var exit

func _ready():
	new_lib = get_node("HBoxContainer/VBoxContainer/new")
	open_lib = get_node("HBoxContainer/VBoxContainer/open")
	guide = get_node("HBoxContainer/VBoxContainer/guide")
	exit = get_node("HBoxContainer/VBoxContainer/exit")
	new_lib.pressed.connect(get_parent()._new_library)
	open_lib.pressed.connect(get_parent()._open_library)
	guide.pressed.connect(get_parent()._guide)
	exit.pressed.connect(self._exit)
	
func _exit():
	get_tree().quit()
