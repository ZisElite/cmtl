extends VBoxContainer

var add
var remove

func _ready():
	add = get_node("top tags container2/add path")
	remove = get_node("top tags container2/remove path")

