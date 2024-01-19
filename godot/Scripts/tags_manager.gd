extends VBoxContainer

var container
var add
var remove

var tag_pre

func _ready():
	container = get_node("tags scroll/tags")
	add = get_node("top tags container/add tag")
	remove = get_node("top tags container/remove tag")
	tag_pre = preload("res://Scenes/tag.tscn")

func populate_tags(tags):
	for tag in tags:
		var temp = tag_pre.instantiate()
		temp.name = str(tag["id"])
		temp.get_node("name").text = tag["name"]
		container.add_child(temp)
