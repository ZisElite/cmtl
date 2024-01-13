extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(self._new_library)

func _new_library():
	pass
