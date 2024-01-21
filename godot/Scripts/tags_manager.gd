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

func connect_buttons_to_master(master):
	add.pressed.connect(master._add_tag)
	remove.pressed.connect(master._remove_tag)

func populate_tags(tags):
	for tag in tags:
		add_tag(tag)

func add_tag(tag):
	var temp = tag_pre.instantiate()
	temp.name = str(tag["id"])
	temp.get_node("name").text = tag["name"]
	container.add_child(temp)
	
func remove_tag(id):
	var temp = container.get_node(str(id))
	container.remove_child(temp)
	temp.queue_free()
