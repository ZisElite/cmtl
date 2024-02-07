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
	var query = "CREATE TABLE paths (
	id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	path TEXT NOT NULL UNIQUE,
	file BOOLEAN NOT NULL
	)"
	db.query(query)
	
	query = "CREATE TABLE files (
	id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	path_id INTEGER NOT NULL REFERENCES paths (id) ON DELETE CASCADE,
	name TEXT UNIQUE NOT NULL,
	format TEXT
	)"
	db.query(query)
	
	query = "CREATE TABLE tags (
	id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	name TEXT NOT NULL UNIQUE
	)"
	db.query(query)

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
	db.insert_row("paths", row)
	db.query("select * from paths where path = \"" + path +  "\"")
	if db.query_result:
		return db.query_result

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
	var query = "CREATE TABLE " + title +" (
	file_id INTEGER UNIQUE NOT NULL REFERENCES files (id) ON DELETE CASCADE
	)"
	db.query(query)

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

func retrieve_files(tag=null, path_id=null):
	var query = "select files.* from files "
	if tag and path_id:
		query += ",paths, " + tag.get_node("name").text + " where  files.path_id = " + \
		path_id.name + " and files.id = " + tag.get_node("name").text + ".file_id and files.path_id = paths.id"
	elif tag:
		query += ", " + tag.get_node("name").text + " where files.id = " + tag.get_node("name").text + ".file_id"
	elif path_id:
		query += ",paths where  files.path_id = " + path_id.name
	print("query ", query)
	db.query(query)
	return db.query_result

func add_tag_to_file(tag, file_id):
	print(tag, " ", file_id)
	var table = {"file_id" : int(str(file_id))}
	db.insert_row(tag, table)

func remove_tag_from_files(tag, file_id):
	print(tag, " ", file_id)
	db.delete_rows(tag, "file_id = " + file_id)
