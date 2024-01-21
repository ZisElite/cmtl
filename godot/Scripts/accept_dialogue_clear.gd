extends ConfirmationDialog


func _ready():
	visibility_changed.connect(self._clear_text)

func _clear_text():
	get_node("tag").text = ""
