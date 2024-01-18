extends Control

var rows_node
var tags_node
var paths_node
var controller
var entry

func _ready():
	rows_node = get_node("master container/library view/data container/VBoxContainer/table/rows")
	tags_node = get_node("master container/library view/data container/tags-path container/tags overall/tags scroll/tags")
	paths_node = get_node("master container/library view/data container/tags-path container/paths overall/paths scroll/paths")
	controller = get_parent()
	entry = preload("res://Scenes/entry.tscn")
