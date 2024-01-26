extends ScrollContainer

var entry_pre
var container_pre
var master_container = null
var container1 = null
var container2 = null
var selected = []

func _ready():
	entry_pre = preload("res://Scenes/entry.tscn")
	container_pre = preload("res://Scenes/entries_container.tscn")

func populate_files(files, paths=null):
	for file in files:
		add_single_file(file, paths)

func add_single_file(file, paths=null):
	var target = null
	if !container1.visible:
		target = container1
	else:
		target = container2
	var temp = entry_pre.instantiate()
	temp.name = str(file["id"])
	temp.get_node("container/name").text = file["name"]
	temp.get_node("container/path").text = str(file["path_id"])
	temp.get_node("container/format").text = file["format"]
	temp.get_node("container/name").pressed.connect(self._file_selected.bind(temp))
	target.add_child(temp)
	if paths:
		paths[file["path_id"]].append(file["id"])

func reset_container():
	selected = []
	if master_container:
		master_container.queue_free()
	master_container = container_pre.instantiate()
	add_child(master_container)
	if container1:
		container1.queue_free()
	container1 = container_pre.instantiate()
	master_container.add_child(container1)
	if container2:
		container2.queue_free()
	container2 = container_pre.instantiate()
	master_container.add_child(container2)
	container2.visible = false

func filter_files(ids=null, mode="unhide"):
	if mode == "unhide":
		for file in container2.get_children():
			container2.remove_child(file)
			container1.add_child(file)
	elif mode == "filter":
		for file in container1.get_children():
			container1.remove_child(file)
			container2.add_child(file)
	if ids and mode == "filter":
		for id in ids:
			var file = container2.get_node(str(id))
			container2.remove_child(file)
			container1.add_child(file)
			

func remove_entries(path_id):
	filter_files()
	for node in container1.get_children():
		if node.get_node("container/path").text == path_id:
			container1.remove_child(node)
			node.queue_free()

func _file_selected(file):
	if file.get_node("container/name").button_pressed:
		selected.append(file)
	else:
		selected.erase(file)
