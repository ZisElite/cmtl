extends VBoxContainer

signal remove_path
signal update_scanning_screen
signal paths_read

var container
var add
var remove
var scan
var master

var path_pre
var group

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
	group = preload("res://resources/paths.tres")

func reset_container():
	print(str(float(Time.get_ticks_msec()) / 1000) + "s: Reseting the paths container.")
	for child in container.get_children():
		container.remove_child(child)
		child.queue_free()

func get_path_nodes():
	return container.get_children()

func populate_paths(paths, initial=false, emit_sig=false):
	print(str(float(Time.get_ticks_msec()) / 1000) + "s: Started populating the paths container.")
	var paths_list =[]
	for path in paths:
		add_single_path(path)
		if initial:
			paths_list.append(path["path"])
	if emit_sig:
		paths_read.emit(paths_list)
	if initial:
		return paths_list

func add_single_path(path, ret=false):
	var temp = path_pre.instantiate()
	temp.name = str(path["id"])
	temp.get_node("name").text = path["path"]
	temp.get_node("name").pressed.connect(self._select_path.bind(temp))
	temp.get_node("type").name = str(path["file"])
	temp.get_node("name").button_group = group
	container.add_child(temp)
	if ret:
		return temp

func connect_buttons_to_master(node):
	master = node
	add.pressed.connect(master._open_files_dialogue)
	remove.pressed.connect(self._remove_path)
	remove_path.connect(master._remove_path)
	scan.pressed.connect(master._start_scanning)
	update_scanning_screen.connect(master._update_scanning_screen)
	paths_read.connect(master.set_paths_list)

func _select_path(button):
	if button.get_node("name").button_pressed:
		selected = button
	else:
		selected = null

func scan_for_files(path):
	print(str(float(Time.get_ticks_msec()) / 1000) + "s: Scanning for files on path " + path + ".")
	if FileAccess.file_exists(path):
		if path.get_extension() in formats:
			var temp = path.split("/")
			return [temp[temp.size()-1]]
	if !DirAccess.dir_exists_absolute(path):
		return null
	var found = []
	var dir = DirAccess.open(path)
	var dirs = dir.get_directories()
	if dirs:
		update_scanning_screen.emit("sub", dirs.size())
	for dire in dirs:
		var result = scan_for_files(path + "/" + dire)
		if result:
			found.append_array(result)
	var files = dir.get_files()
	if files:
		update_scanning_screen.emit("files", files.size())
	for file in files:
		if file.get_extension() in formats:
			found.append(file)
	print(str(float(Time.get_ticks_msec()) / 1000) + "s: Finished file scanning.")
	return (found)


func _remove_path():
	if !selected:
		print(str(float(Time.get_ticks_msec()) / 1000) + "s: No path was selected before pressing the - button.")
		master.message.text = "Please select a path before pressing the - button."
	var temp_id = selected.name
	var temp_name = selected.get_node("name").text
	container.remove_child(selected)
	selected.queue_free()
	selected = null
	remove_path.emit(temp_id, temp_name)
