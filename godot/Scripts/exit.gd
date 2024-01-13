extends Button


func _ready():
	pressed.connect(self._button_pressed)

func _button_pressed():
	get_tree().quit()
	
#func _input(event):
#	if event is InputEventKey and OS.get_keycode_string(event.keycode) == "Escape":
#		get_tree().quit()
