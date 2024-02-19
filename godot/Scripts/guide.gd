extends Control

var back

func _ready():
	back = get_node("ScrollContainer/VBoxContainer/back")
	back.pressed.connect(get_parent()._main_menu)
	visibility_changed.connect(self._reset)
	
func _reset():
	if !visible:
		print(str(float(Time.get_ticks_msec()) / 1000) + "s: Reseting guide scroll area to 0 vertical.")
		get_node("ScrollContainer/VBoxContainer/ScrollContainer").scroll_vertical = 0
