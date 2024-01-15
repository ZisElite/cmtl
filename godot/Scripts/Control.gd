extends Control

var main
var new_lib
var open_lib

func _ready():
	main = get_node("main menu")
	new_lib = get_node("new library")
	open_lib = get_node("open library")

func _main_menu():
	main.visible = true
	new_lib.visible = false
	open_lib.visible = false

func _new_library():
	main.visible = false
	new_lib.visible = true
	open_lib.visible = false
	
func _open_library():
	main.visible = false
	new_lib.visible = false
	open_lib.visible = true

func _input(event):
	if event is InputEventKey and OS.get_keycode_string(event.keycode) == "Escape":
		get_tree().quit()
