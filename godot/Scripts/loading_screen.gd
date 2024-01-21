extends Control

var location
var number

func _ready():
	location = get_node("PanelContainer/CenterContainer/VBoxContainer/HBoxContainer/loc")
	number = get_node("PanelContainer/CenterContainer/VBoxContainer/HBoxContainer2/number")


func _toggle_visible(vis):
	visible = vis

func _update_text(text, num):
	location.text = text
	number.text = num

