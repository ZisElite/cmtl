extends Node

var db : SQLite
var dir : DirAccess
var libs_path
func _ready():
	libs_path = "user://libraries/"
	db = SQLite.new()
	dir = DirAccess.open("user://")
	dir.make_dir("libraries")
	dir = DirAccess.open(libs_path)
	var files = dir.get_files()
	print(files)

func get_libs():
	return(dir.get_files())
	
func check_new(lib):
	var files = dir.get_files()
	if (lib+".db" not in files or files.is_empty()) and lib != "":
		return true
	return false

# create new library and add the three default tables "paths", "files" and "tags"
func create_new_library(lib):
	db.path = libs_path+lib+".db"
	db.open_db()
	var table = {
		"id" : {"data_type" : "int", "primary_key" : true, "not_null" : true, "auto_increment" : true},
		"path" : {"data_type": "text", "not_null": true},
		"file" : {"data_type" : "bool", "not_null": true}
	}
	db.create_table("paths", table)
	
	table = {
		"id" : {"data_type" : "int", "primary_key" : true, "not_null" : true, "auto_increment" : true},
		"path" : {"data_type": "text", "not_null": true},
		"name" : {"data_type" : "text", "not_null": true},
		"format" : {"data_type" : "text"}
	}
	db.create_table("files", table)
	
	table = {
		"id" : {"data_type" : "int", "primary_key" : true, "not_null" : true, "auto_increment" : true},
		"name" : {"data_type": "text", "not_null": true}
	}
	db.create_table("tags", table)

func open_library(lib):
	db.path = libs_path+lib+".db"
	db.open_db()

func remove_lib(lib):
	dir.remove(lib+".db")
