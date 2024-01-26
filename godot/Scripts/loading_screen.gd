extends Control

var location
var sub_number
var file_number

func _ready():
	location = get_node("PanelContainer/CenterContainer/VBoxContainer/scanning/location")
	sub_number = get_node("PanelContainer/CenterContainer/VBoxContainer/subfolders cont/number")
	file_number = get_node("PanelContainer/CenterContainer/VBoxContainer/files cont/number")


func _toggle_visible(vis):
	visible = vis

func _update_text(text, sub_num, file_num):
	location.text = text
	sub_number.text = sub_num
	file_number.text = file_num

