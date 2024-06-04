extends Control

var location
var sub_number
var file_number

func _ready():
	location = get_node("PanelContainer/CenterContainer/VBoxContainer/scanning/location")
	sub_number = get_node("PanelContainer/CenterContainer/VBoxContainer/subfolders cont/number")
	file_number = get_node("PanelContainer/CenterContainer/VBoxContainer/files cont/number")


func toggle_visible(vis):
	visible = vis

func update_loc(loc=""):
	location.text = loc

func update_sub(sub_num="0"):
	sub_number.text = sub_num

func update_files(file_num="0"):
	file_number.text = file_num 