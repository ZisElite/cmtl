extends Control

signal confirm_selected

var confirm
var delete
var cancel
var scroll
var sqlite
var message
var lib_pre

var selected = null
var group = null

func _ready():
	confirm = get_node("HBoxContainer/VBoxContainer/HBoxContainer/confirm")
	delete = get_node("HBoxContainer/VBoxContainer/HBoxContainer/delete")
	cancel = get_node("HBoxContainer/VBoxContainer/HBoxContainer/cancel")
	sqlite = get_parent().get_node("SQLite manager")
	scroll = get_node("HBoxContainer/VBoxContainer/libraries container/libraries")
	message = get_node("HBoxContainer/VBoxContainer/message")
	message.text = ""
	lib_pre = preload("res://Scenes/library.tscn")
	group = preload("res://resources/libraries.tres")
	confirm.pressed.connect(self._check_pressed)
	confirm_selected.connect(get_parent()._prepare_library_view)
	delete.pressed.connect(self._remove_lib)
	cancel.pressed.connect(get_parent()._main_menu)
	visibility_changed.connect(self._reset)

func populate_list(files):
	print(str(float(Time.get_ticks_msec()) / 1000) + "s: Started populating library list.")
	for file in files:
		if file.get_extension() == "db":
			var nam = file.substr(0, file.length() - 3)
			add_single_lib(nam)

func add_single_lib(title):
	var temp = lib_pre.instantiate()
	temp.name = title
	temp.get_node("name").text = title
	temp.get_node("name").pressed.connect(self._select.bind(temp))
	temp.get_node("name").button_group = group
	scroll.add_child(temp)

func _select(lib):
	selected = lib

func _reset():
	print(str(float(Time.get_ticks_msec()) / 1000) + "s: Reseting the pressed buttons.")
	if selected:
		selected.get_node("name").button_pressed = false
		selected = null
	message.text = ""

func _check_pressed():
	if !selected:
		print(str(float(Time.get_ticks_msec()) / 1000) + "s: No library was selected before pressing confirm.")
		message.text = "Please select a library to load before pressing the CONFIRM button."
		return
	confirm_selected.emit(selected.name)

func _remove_lib():
	if !selected:
		print(str(float(Time.get_ticks_msec()) / 1000) + "s: No library was selected before pressing delete.")
		message.text = "Please select a library and then press the DELETE button."
		return
	var result = sqlite.remove_lib(selected.name)
	if result:
		print(str(float(Time.get_ticks_msec()) / 1000) + "s: There was an error deleting the library.")
		message.text = "There was an error during library deletion."
		return
	scroll.remove_child(selected)
	message.text = "Library " + selected.name + " successfully removed."
	selected.queue_free()
	selected = null
	print(str(float(Time.get_ticks_msec()) / 1000) + "s: Library deleted successfully.")
	
