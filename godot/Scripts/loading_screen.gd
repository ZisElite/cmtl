extends Control

signal continue_setup

var message

func _ready():
	message = get_node("PanelContainer/CenterContainer/VBoxContainer/message")


func toggle_visible(vis):
	visible = vis
	await get_tree().process_frame
	continue_setup.emit()

func update_message(text):
	message.text = text
