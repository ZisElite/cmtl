extends VBoxContainer

signal remove_path

var container
var add
var remove
var scan

var path_pre

var selected = null
var formats = ["3gp", "aa", "aax", "act", "aiff", "alac", "amr", "ape", "au", "awb", "dss", "dvf",
"flac", "gsm", "iklax", "ivs", "m4b", "m4p", "mmf", "movpkg", "mp3", "mpc", "msv", "nmf", "ogg",
"oga", "mogg", "opus", "ra", "rm", "raw", "rf64", "sln", "tta", "voc", "vox", "wav", "wma", "wv",
"webm", "8svx", "cda"]

func _ready():
	container = get_node("paths scroll/paths")
	add = get_node("top tags container2/add path")
	remove = get_node("top tags container2/remove path")
	scan = get_node("top tags container2/scan")
	path_pre = preload("res://Scenes/path.tscn")

func get_path_nodes():
	return container.get_children()

func populate_paths(paths, initial=false):
	var paths_list =[]
	for path in paths:
		var temp = path_pre.instantiate()
		temp.name = str(path["id"])
		temp.get_node("name").text = path["path"]
		temp.get_node("name").pressed.connect(self._select_path.bind(temp))
		temp.get_node("type").name = str(path["file"])
		container.add_child(temp)
		if initial:
			paths_list.append(path["path"])
	if initial:
		return paths_list

func add_single_path(path):
	var temp = path_pre.instantiate()
	temp.get_node("name").text = path
	temp.get_node("name").pressed.connect(self._select_path.bind(temp))
	container.add_child(temp)

func connect_buttons_to_master(master):
	add.pressed.connect(master._open_files_dialogue)
	remove.pressed.connect(self._remove_path)
	remove_path.connect(master._remove_path)
	scan.pressed.connect(master._scan_paths)

func _select_path(button):
	selected = button
	print(button.name)

func scan_for_files(path):
	if FileAccess.file_exists(path):
		if path.get_extension() in formats:
			var temp = path.split("/")
			return [temp[temp.size()-1]]
	if !DirAccess.dir_exists_absolute(path):
		return null
	var found = []
	var dir = DirAccess.open(path)
	var dirs = dir.get_directories()
	for dire in dirs:
		print(dire)
		var result = scan_for_files(path + "/" + dire)
		if result:
			found.append_array(result)
	var files = dir.get_files()
	for file in files:
		if file.get_extension() in formats:
			found.append(file)
	return (found)


func _remove_path():
	if selected:
		remove_path.emit(selected)
		remove_child(selected)
		selected.queue_free()
		selected = null
