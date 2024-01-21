extends Control

signal confirm_selected
signal delete_lib

var confirm
var delete
var cancel
var scroll
var lib_pre

var selected = null

func _ready():
	confirm = get_node("ScrollContainer/HBoxContainer/VBoxContainer/HBoxContainer/confirm")
	delete = get_node("ScrollContainer/HBoxContainer/VBoxContainer/HBoxContainer/delete")
	cancel = get_node("ScrollContainer/HBoxContainer/VBoxContainer/HBoxContainer/cancel")
	scroll = get_node("ScrollContainer/HBoxContainer/VBoxContainer/libraries container/libraries")
	lib_pre = preload("res://Scenes/library.tscn")
	confirm.pressed.connect(self._check_pressed)
	confirm_selected.connect(get_parent()._view_library)
	delete.pressed.connect(self._send_for_deletion)
	delete_lib.connect(get_parent()._remove_lib)
	cancel.pressed.connect(get_parent()._main_menu)
	visibility_changed.connect(self._clear_buttons)

func populate_list(files):
	for file in files:
		if file.get_extension() == "db":
			var nam = file.substr(0, file.length() - 3)
			add_single_lib(nam)

func add_single_lib(title):
	var temp = lib_pre.instantiate()
	temp.name = title
	temp.get_node("name").text = title
	temp.get_node("name").pressed.connect(self._select.bind(title))
	scroll.add_child(temp)

func _select(nam):
	selected = nam
	print (selected)

func _clear_buttons():
	if selected:
		scroll.get_node(selected + "/name").button_pressed = false
		selected = null

func _check_pressed():
	if selected:
		confirm_selected.emit(selected)

func _send_for_deletion():
	if selected:
		delete_lib.emit(selected)

func remove_lib(lib):
	var temp = scroll.get_node(lib)
	remove_child(temp)
	temp.queue_free()
	selected = null
