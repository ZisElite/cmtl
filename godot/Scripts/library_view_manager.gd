extends Control

var rows_node
var tags_node
var paths_node

var controller
var sqlite
var new_files

var entry_pre

func _ready():
	rows_node = get_node("master container/library view/data container/VBoxContainer/table/entries")
	tags_node = get_node("master container/library view/data container/tags-path container/tags overall")
	paths_node = get_node("master container/library view/data container/tags-path container/paths overall")
	controller = get_parent()
	sqlite = controller.get_node("SQLite manager")
	new_files = get_node("new_files")
	entry_pre = preload("res://Scenes/entry.tscn")

func setup(lib):
	sqlite.open_library(lib)
	var result = sqlite.read_table("paths")
	paths_node.populate_paths(result)
	result = sqlite.read_table("tags")
	tags_node.populate_tags(result)
	result = sqlite.read_table("files")
	populate_files(result)

func populate_files(files):
	print(files)
	for file in files:
		var temp = entry_pre.instantiate()
		temp.name = str(file["id"])
		temp.get_node("container/name").text = file["name"]
		temp.get_node("container/path").text = str(file["path_id"])
		temp.get_node("container/format").text = file["format"]
		rows_node.add_child(temp)
