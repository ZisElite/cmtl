extends ScrollContainer

var entry_pre
var container_pre
var container
var selected = []

func _ready():
	entry_pre = preload("res://Scenes/entry.tscn")
	container_pre = preload("res://Scenes/entries_container.tscn")

func populate_files(files):
	for file in files:
		add_single_file(file)

func add_single_file(file):
	var temp = entry_pre.instantiate()
	temp.name = str(file["id"])
	temp.get_node("container/name").text = file["name"]
	temp.get_node("container/path").text = str(file["path_id"])
	temp.get_node("container/format").text = file["format"]
	temp.get_node("container/name").pressed.connect(self._file_selected.bind(temp))
	container.add_child(temp)

func reset_container():
	selected = []
	if container:
		container.queue_free()
	container = container_pre.instantiate()
	add_child(container)

func _file_selected(file):
	if file.get_node("container/name").button_pressed:
		selected.append(file)
	else:
		selected.erase(file)
