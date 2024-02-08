extends Control

signal _scan_finished
signal disable_esc
signal free_esc
signal go_back
signal continue_scan

var entries_node
var tags_node
var paths_node
var controller
var scanning
var sqlite
var new_files
var new_tag
var remove_tag
var apply_filter
var clear_filter
var apply_tag_to_files
var remove_tag_from_files
var back_button

var entry_pre

var paths_list = null
var active_tag = null
var active_path = null
var filters_active = false

var paths = {}
var tags = {}

var total_scanned_subs = 0
var total_scanned_files = 0

var formats = ["3gp", "aa", "aax", "act", "aiff", "alac", "amr", "ape", "au", "awb", "dss", "dvf",
"flac", "gsm", "iklax", "ivs", "m4b", "m4p", "mmf", "movpkg", "mp3", "mpc", "msv", "nmf", "ogg",
"oga", "mogg", "opus", "ra", "rm", "raw", "rf64", "sln", "tta", "voc", "vox", "wav", "wma", "wv",
"webm", "8svx", "cda"]

var thread: Thread

func _ready():
	entries_node = get_node("master container/library view/data container/VBoxContainer/table")
	tags_node = get_node("master container/library view/data container/VBoxContainer2/tags-path container/tags overall")
	paths_node = get_node("master container/library view/data container/VBoxContainer2/tags-path container/paths overall")
	controller = get_parent()
	scanning = controller.get_node("scanning")
	sqlite = controller.get_node("SQLite manager")
	new_files = get_node("new_files")
	new_files.file_selected.connect(self._add_path.bind(true))
	new_files.dir_selected.connect(self._add_path.bind(false))
	new_files.canceled.connect(controller._free_esc)
	new_tag = get_node("new tag dialogue")
	new_tag.register_text_enter(new_tag.get_node("tag"))
	new_tag.confirmed.connect(self._new_tag_confirmed)
	new_tag.canceled.connect(controller._free_esc)
	remove_tag = get_node("remove tag dialogue")
	remove_tag.register_text_enter(remove_tag.get_node("tag"))
	remove_tag.confirmed.connect(self._remove_tag_confirmed)
	remove_tag.canceled.connect(controller._free_esc)
	entry_pre = preload("res://Scenes/entry.tscn")
	
	paths_node.connect_buttons_to_master(self)
	tags_node.connect_buttons_to_master(self)
	
	apply_filter = get_node("master container/library view/data container/VBoxContainer2/HBoxContainer/apply")
	clear_filter = get_node("master container/library view/data container/VBoxContainer2/HBoxContainer/clear")
	apply_filter.pressed.connect(self._apply_filters)
	clear_filter.pressed.connect(self._clear_filters)
	
	apply_tag_to_files = get_node("master container/library view/data container/VBoxContainer/buttons/apply tags")
	remove_tag_from_files = get_node("master container/library view/data container/VBoxContainer/buttons/remove tags")
	apply_tag_to_files.pressed.connect(self._apply_tag_to_files)
	remove_tag_from_files.pressed.connect(self._remove_tag_from_files)
	
	back_button = get_node("master container/library view/data container/VBoxContainer/buttons/back")
	back_button.pressed.connect(self._main_menu)
	go_back.connect(controller._main_menu)
	
	_scan_finished.connect(self._scan_complete)

			
func setup(lib):
	entries_node.reset_container()
	sqlite.open_library(lib)
	var result = sqlite.read_table("paths")
	create_path_dict(result)
	paths_list = paths_node.populate_paths(result, true)
	result = sqlite.read_table("tags")
	create_tag_dict(result)
	tags_node.populate_tags(result)
	result = sqlite.read_table("files")
	entries_node.populate_files(result, paths)
	entries_node.filter_files()

func create_path_dict(results):
	for result in results:
		paths[result["id"]] = []

func create_tag_dict(results):
	for result in results:
		tags[result["name"]] = []
		var temp = sqlite.read_table(result["name"])
		for entry in temp:
			tags[result["name"]].append(entry["file_id"])
	print(tags)

func _main_menu():
	entries_node.reset_container()
	tags_node.reset_container()
	paths_node.reset_container()
	sqlite.close_library()
	active_path = null
	active_tag = null
	go_back.emit()
	
#-------------------------------------

func _open_files_dialogue():
	new_files.visible = true

func _add_path(path, type):
	free_esc.emit()
	if path not in paths_list:
		if type and path.get_extension() not in formats:
			return
		var result = sqlite.add_path(path, type)
		if result:
			var temp = paths_node.add_single_path(result[0], true)
			print(result[0])
			paths[result[0]["id"]] = []
			paths_list.append(path)
			_start_scanning("single", temp)
			print(paths)

func _remove_path(id, nam):
	if sqlite.remove_path(id):
		paths_list.erase(nam)
		paths.erase(int(str(id)))
		entries_node.remove_entries(id)
		print(paths)
		filters()
		

func _start_scanning(mode="all", path=null):
	thread = Thread.new()
	thread.start(scan_paths.bind(mode, path))

func scan_paths(mode="all", single_path=null):
	Thread.set_thread_safety_checks_enabled(false)
	total_scanned_files = 0
	total_scanned_subs = 0
	scanning.toggle_visible(true)
	if mode == "all":
		if paths_list:
			var pathss = paths_node.get_path_nodes()
			for path in pathss:
				scanning.update_loc(path.get_node("name").text)
				scan_single_path(path)
	elif mode == "single":
		scanning.update_loc(single_path.get_node("name").text)
		scan_single_path(single_path)
	else:
		print("scanning mode was wrong: " + str(mode))
	_scan_finished.emit()

func scan_single_path(path):
	var temp = paths_node.scan_for_files(path.get_node("name").text)
	for file in temp:
		var path_id = path.name
		var result =  sqlite.add_file(file, path_id)
		if result:
			entries_node.call_deferred("add_single_file", result, paths)
			
func _scan_complete():
	filters()
	scanning.toggle_visible(false)

func _update_scanning_screen(which, numbers):
	if which == "sub":
		total_scanned_subs += numbers
		scanning.update_sub(str(total_scanned_subs))
	elif which == "files":
		total_scanned_files += numbers
		scanning.update_files(str(total_scanned_files))
	else:
		print("WHICH parameter in update_scanning_screen was somehow wrong: " + str(which))

#-------------------------------------

func _add_tag():
	new_tag.visible = true

func _new_tag_confirmed():
	free_esc.emit()
	var new_tag_name = new_tag.get_node("tag").text
	print(new_tag_name)
	if new_tag_name:
		var result = sqlite.add_new_tag(new_tag_name)
		if result:
			print(result)
			tags_node.add_tag(result)
			tags[result["name"]] = []
			print(tags)

func _remove_tag():
	remove_tag.visible = true

func _remove_tag_confirmed():
	free_esc.emit()
	var remove_tag_name = remove_tag.get_node("tag").text
	if remove_tag_name:
		var id = sqlite.remove_tag(remove_tag_name)
		if id and sqlite.drop_tag_table(remove_tag_name):
			tags.erase(remove_tag_name)
			tags_node.remove_tag(id)
			print(tags)

#-------------------------------------

func _apply_filters():
	filters_active = false
	var mode = "unhide"
	print("applying filters")
	active_path = paths_node.selected
	active_tag = tags_node.selected
	var filtered_files = []
	if active_path:
		mode = "filter"
		filters_active = true
		for id in paths[int(str(active_tag.name))]:
			if id not in filtered_files:
				filtered_files.append(id)
	if active_tag:
		mode = "filter"
		filters_active = true
		for id in tags[active_tag.get_node("name").text]:
			if id not in filtered_files:
				filtered_files.append(id)
	entries_node.filter_files(filtered_files, mode)
	
func _clear_filters():
	filters_active = false
	if paths_node.selected:
		active_path = null
		paths_node.selected.get_node("name").button_pressed = false
		paths_node.selected = null
	if tags_node.selected:
		active_tag = null
		tags_node.selected.get_node("name").button_pressed = false
		tags_node.selected = null
	entries_node.filter_files()

#-------------------------------------

func _apply_tag_to_files():
	if tags_node.selected:
		var tag = tags_node.selected.get_node("name").text
		var files = entries_node.selected
		if files:
			for file in files:
				if sqlite.add_tag_to_file(tag, file.name):
					tags[tag].append(int(str(file.name)))
					print(tags)
			
func _remove_tag_from_files():
	if tags_node.selected:
		var tag = tags_node.selected.get_node("name").text
		var files = entries_node.selected
		if files:
			for file in files:
				print(file)
				if sqlite.remove_tag_from_files(tag, file.name):
					tags[tag].erase(int(str(file.name)))
					print(tags)
			if active_tag.get_node("name").text == tag:
				var result = sqlite.retrieve_files(active_tag, active_path)
				entries_node.reset_container()
				if result:
					print(result)
					entries_node.populate_files(result)

func filters():
	if filters_active:
		_apply_filters()
	else:
		_clear_filters()

#-------------------------------------

func _exit_tree():
	if thread:
		thread.wait_to_finish()
