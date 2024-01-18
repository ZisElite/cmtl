extends Control


var confirm
var cancel
var scroll
var lib

var selected = null

func _ready():
	confirm = get_node("ScrollContainer/HBoxContainer/VBoxContainer/HBoxContainer/confirm")
	cancel = get_node("ScrollContainer/HBoxContainer/VBoxContainer/HBoxContainer/cancel")
	scroll = get_node("ScrollContainer/HBoxContainer/VBoxContainer/libraries container/libraries")
	lib = preload("res://Scenes/library.tscn")
	confirm.pressed.connect(get_parent()._view_library)
	cancel.pressed.connect(get_parent()._main_menu)
	visibility_changed.connect(self._clear_buttons)

func populate_list(files):
	for file in files:
		if file.get_extension() == "db":
			var nam = file.substr(0, file.length() - 3)
			var temp = lib.instantiate()
			temp.name = nam
			temp.get_node("name").text = nam
			temp.get_node("name").pressed.connect(self._select.bind(nam))
			scroll.add_child(temp)

func _select(nam):
	selected = nam
	print (selected)

func _clear_buttons():
	if selected:
		scroll.get_node(selected + "/name").button_pressed = false
		selected = null
