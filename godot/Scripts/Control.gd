extends Control

var free_esc = false

var main
var guide
var new_lib
var open_lib
var view_lib
var sqlite

func _ready():
	main = get_node("main menu")
	guide = get_node("guide")
	new_lib = get_node("new library")
	open_lib = get_node("open library")
	view_lib = get_node("library view")
	sqlite = get_node("SQLite manager")
	var files = sqlite.get_libs()
	open_lib.populate_list(files)

func _main_menu():
	print("D" + Time.get_datetime_string_from_system() + ": Switching to main menu screen.")
	main.visible = true
	new_lib.visible = false
	open_lib.visible = false
	view_lib.visible = false
	guide.visible = false

func _new_library():
	print("D" + Time.get_datetime_string_from_system() + ": Switching to new library screen.")
	main.visible = false
	new_lib.visible = true
	open_lib.visible = false
	view_lib.visible = false
	guide.visible = false
	
func _open_library():
	print("D" + Time.get_datetime_string_from_system() + ": Switching to open library screen.")
	main.visible = false
	new_lib.visible = false
	open_lib.visible = true
	view_lib.visible = false
	guide.visible = false

func _view_library():
	print("D" + Time.get_datetime_string_from_system() + ": Switching to library view screen.")
	main.visible = false
	new_lib.visible = false
	open_lib.visible = false
	view_lib.visible = true
	guide.visible = false

func _guide():
	print("D" + Time.get_datetime_string_from_system() + ": Switching to guide screen.")
	main.visible = false
	new_lib.visible = false
	open_lib.visible = false
	view_lib.visible = false
	guide.visible = true
	
func _prepare_new(lib):
	print("D" + Time.get_datetime_string_from_system() + ": Adding new library to the list.")
	open_lib.add_single_lib(lib)
	_prepare_library_view(lib)

func _prepare_library_view(lib):
	view_lib.setup_start(lib)

func _free_esc():
	free_esc = true

func _input(event):
	if event is InputEventKey and !event.pressed and OS.get_keycode_string(event.keycode) == "Escape":
		if free_esc:
			free_esc = false
		else:
			get_tree().quit()
