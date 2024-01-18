extends Control

var main
var new_lib
var open_lib
var view_lib
var sqlite

func _ready():
	main = get_node("main menu")
	new_lib = get_node("new library")
	open_lib = get_node("open library")
	view_lib = get_node("library view")
	sqlite = get_node("SQLite manager")
	var files = sqlite.get_libs()
	open_lib.populate_list(files)

func _main_menu():
	main.visible = true
	new_lib.visible = false
	open_lib.visible = false
	view_lib.visible = false

func _new_library():
	main.visible = false
	new_lib.visible = true
	open_lib.visible = false
	view_lib.visible = false
	
func _open_library():
	main.visible = false
	new_lib.visible = false
	open_lib.visible = true
	view_lib.visible = false

func _view_library():
	main.visible = false
	new_lib.visible = false
	open_lib.visible = false
	view_lib.visible = true
	
func _check_new(lib):
	if sqlite.check_new(lib):
		sqlite.create_new_library(lib)
		_view_library()

func _input(event):
	if event is InputEventKey and OS.get_keycode_string(event.keycode) == "Escape":
		get_tree().quit()
