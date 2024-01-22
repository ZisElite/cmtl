extends ScrollContainer

var entry_pre
var container_pre
var container

func _ready():
	entry_pre = preload("res://Scenes/entry.tscn")
	container_pre = preload("res://Scenes/entries_container.tscn")

func populate_files(files):
	print(files)
	for file in files:
		add_single_file(file)

func add_single_file(file):
	print("file", file)
	var temp = entry_pre.instantiate()
	temp.name = str(file["id"])
	temp.get_node("container/name").text = file["name"]
	temp.get_node("container/path").text = str(file["path_id"])
	temp.get_node("container/format").text = file["format"]
	container.add_child(temp)

func reset_container():
	if container:
		container.queue_free()
	container = container_pre.instantiate()
	add_child(container)
