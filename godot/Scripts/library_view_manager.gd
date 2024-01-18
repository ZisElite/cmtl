extends Control

var rows_node

func _ready():
	rows_node = get_node("master container/library view/data container/VBoxContainer/table/rows")
