extends Node

var db : SQLite
var dir

func _ready():
	dir = DirAccess.open("user://")
	dir.make_dir("libraries")
	dir = DirAccess.open("user://libraries/")
	var files = dir.get_files()
	print(files)

func check_new(lib):
	var files = dir.get_files()
	if lib+".db" in files or files.is_empty():
		return true
	return false
