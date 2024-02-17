extends VBoxContainer

var container
var add
var remove
var master

var tag_pre
var group

var selected

func _ready():
	container = get_node("tags scroll/tags")
	add = get_node("top tags container/add tag")
	remove = get_node("top tags container/remove tag")
	tag_pre = preload("res://Scenes/tag.tscn")
	group = preload("res://resources/tags.tres")

func reset_container():
	print("D" + Time.get_datetime_string_from_system() + ": Reseting the tags container.")
	for child in container.get_children():
		container.remove_child(child)
		child.queue_free()

func connect_buttons_to_master(node):
	master = node
	add.pressed.connect(master._add_tag)
	remove.pressed.connect(master._remove_tag)

func _select_tag(button):
	if button.get_node("name").button_pressed:
		selected = button
	else:
		selected = null

func populate_tags(tags):
	print("D" + Time.get_datetime_string_from_system() + ": Started populating tags container.")
	for tag in tags:
		add_tag(tag)

func add_tag(tag):
	var temp = tag_pre.instantiate()
	temp.name = str(tag["id"])
	temp.get_node("name").text = tag["name"]
	temp.get_node("name").button_group = group
	temp.get_node("name").pressed.connect(self._select_tag.bind(temp))
	container.add_child(temp)
	
func remove_tag(id):
	var temp = container.get_node(str(id))
	container.remove_child(temp)
	temp.queue_free()
