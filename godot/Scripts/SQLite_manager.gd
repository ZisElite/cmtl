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
		"path" : {"data_type": "text", "not_null": true, "unique" : true},
		"file" : {"data_type" : "boolean", "not_null": true}
	}
	db.create_table("paths", table)
	
	table = {
		"id" : {"data_type" : "int", "primary_key" : true, "not_null" : true, "auto_increment" : true},
		"path_id" : {"data_type": "int", "not_null": true, "foreign_key" : "paths.id"},
		"name" : {"data_type" : "text", "not_null": true, "unique" : true},
		"format" : {"data_type" : "text"}
	}
	db.create_table("files", table)
	
	table = {
		"id" : {"data_type" : "int", "primary_key" : true, "not_null" : true, "auto_increment" : true},
		"name" : {"data_type": "text", "not_null": true, "unique" : true}
	}
	db.create_table("tags", table)

func open_library(lib):
	db.path = libs_path+lib+".db"
	db.foreign_keys = true
	db.open_db()

func remove_lib(lib):
	dir.remove(lib+".db")

func read_table(table):
	db.query("select * from "+table)
	return db.query_result

#-------------------------------------

func add_path(path, type):
	var row = {"path" : path, "file" : type}
	print(db.insert_row("paths", row))

func remove_path(path_id):
	print(db.delete_rows("paths", "id = " + path_id))

#-------------------------------------

func add_new_tag(tag_name):
	var table = {"name" : tag_name}
	if db.insert_row("tags", table):
		create_tag_table(tag_name)
		db.query("select * from tags where name = \"" + tag_name + "\"")
		return db.query_result[0]

func create_tag_table(title):
	var table = {
		"file_id" : {"data_type" : "int", "not_null" : true, "unique" : true, "foreign_key" : "files.id"}
	}
	db.create_table(title, table)

func remove_tag(tag_name):
	var id = null
	if db.query("select id from tags where name = \"" + tag_name + "\""):
		id = db.query_result[0]["id"]
		db.delete_rows("tags", "name = \"" + tag_name + "\"")
	return id

#-------------------------------------

func add_file(file, path_id):
	var nam = file.left(-( 1 + file.get_extension().length()))
	var table = {"path_id" : int(str(path_id)), "name" : nam, "format" : file.get_extension()}
	if db.insert_row("files", table):
		db.query("select * from files where name = \"" + nam + "\"")
		return db.query_result[0]
