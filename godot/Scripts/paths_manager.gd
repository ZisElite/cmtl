extends VBoxContainer

var container
var add
var remove
var scan

var path_pre

func _ready():
	container = get_node("paths scroll/paths")
	add = get_node("top tags container2/add path")
	remove = get_node("top tags container2/remove path")
	scan = get_node("top tags container2/scan")
	path_pre = preload("res://Scenes/path.tscn")

func populate_paths(paths):
	for path in paths:
		var temp = path_pre.instantiate()
		temp.name = str(path["id"])
		temp.get_node("name").text = str(path["id"]) + "." + path["path"]
		container.add_child(temp)
