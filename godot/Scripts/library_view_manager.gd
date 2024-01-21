extends Control

var rows_node
var tags_node
var paths_node

var controller
var sqlite
var new_files
var new_tag
var remove_tag

var entry_pre

var paths_list = null
var tags_list = null

var formats = ["3gp", "aa", "aax", "act", "aiff", "alac", "amr", "ape", "au", "awb", "dss", "dvf",
"flac", "gsm", "iklax", "ivs", "m4b", "m4p", "mmf", "movpkg", "mp3", "mpc", "msv", "nmf", "ogg",
"oga", "mogg", "opus", "ra", "rm", "raw", "rf64", "sln", "tta", "voc", "vox", "wav", "wma", "wv",
"webm", "8svx", "cda"]

func _ready():
	rows_node = get_node("master container/library view/data container/VBoxContainer/table/entries")
	tags_node = get_node("master container/library view/data container/tags-path container/tags overall")
	paths_node = get_node("master container/library view/data container/tags-path container/paths overall")
	controller = get_parent()
	sqlite = controller.get_node("SQLite manager")
	new_files = get_node("new_files")
	new_files.file_selected.connect(self._add_path.bind(true))
	new_files.dir_selected.connect(self._add_path.bind(false))
	new_tag = get_node("new_tag dialogue")
	new_tag.register_text_enter(new_tag.get_node("new tag"))
	new_tag.confirmed.connect(self._new_tag_confirmed)
	remove_tag = get_node("remove tag dialogue")
	remove_tag.register_text_enter(remove_tag.get_node("remove tag"))
	remove_tag.confirmed.connect(self._remove_tag_confirmed)
	entry_pre = preload("res://Scenes/entry.tscn")
	
	paths_node.connect_buttons_to_master(self)
	tags_node.connect_buttons_to_master(self)

func setup(lib):
	sqlite.open_library(lib)
	var result = sqlite.read_table("paths")
	paths_list = paths_node.populate_paths(result, true)
	print(paths_list)
	result = sqlite.read_table("tags")
	tags_node.populate_tags(result)
	result = sqlite.read_table("files")
	populate_files(result)
	
#-------------------------------------

func populate_files(files):
	print(files)
	for file in files:
		var temp = entry_pre.instantiate()
		temp.name = str(file["id"])
		temp.get_node("container/name").text = file["name"]
		temp.get_node("container/path").text = str(file["path_id"])
		temp.get_node("container/format").text = file["format"]
		rows_node.add_child(temp)

#-------------------------------------

func _open_files_dialogue():
	new_files.visible = true

func _add_path(path, type):
	if path not in paths_list:
		if type and path.get_extension() not in formats:
			return
		sqlite.add_path(path, type)
		paths_node.add_single_path(path)
		paths_list.append(path)
		
func _remove_path(selected):
	sqlite.remove_path(selected.name)
	paths_list.erase(selected.get_node("name").text)

func _scan_paths():
	var files = []
	for path in paths_list:
		var temp = paths_node.scan_dir(path)
		if temp:
			files.append_array(temp)
	print(files)
	
#-------------------------------------

func _add_tag():
	new_tag.visible = true

func _new_tag_confirmed():
	var new_tag_name = new_tag.get_node("tag").text
	if new_tag_name:
		var result = sqlite.add_new_tag(new_tag_name)
		if result:
			print(result)
			tags_node.add_tag(result)
			

func _remove_tag():
	remove_tag.visible = true

func _remove_tag_confirmed():
	var remove_tag_name = remove_tag.get_node("tag").text
	if remove_tag_name:
		var id = sqlite.remove_tag(remove_tag_name)
		if id:
			tags_node.remove_tag(id)