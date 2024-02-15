extends Node

var dir: DirAccess
var file: FileAccess
var logs_path
# Called when the node enters the scene tree for the first time.
func _ready():
	logs_path = "user://client logs/"
	dir = DirAccess.open("user://")
	dir.make_dir("client logs")
	dir = DirAccess.open(logs_path)
	var datetime = "D" + Time.get_datetime_string_from_system().replace(":", "-") + ".txt"
	print(datetime)
	file = FileAccess.open(logs_path + datetime, FileAccess.WRITE)

func _log(text):
	file.store_string(Time.get_datetime_string_from_system(false, true) + ": " + text)
