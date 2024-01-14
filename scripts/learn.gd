extends ColorRect

var temp = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("respawn", self, "respawn")
	pass # Replace with function body.

func respawn():
	temp = 3
	pass

func _on_ColorRect_gui_input(event):
	if Input.is_action_just_released("left_mouse_button"):
		match temp:
			1:
				Events.emit_signal("use_cutscene_1", "learn_1_off")
				mouse_filter = Control.MOUSE_FILTER_IGNORE
				temp = 2
			2:
				Events.emit_signal("use_cutscene_1", "learn_2_off")
				mouse_filter = Control.MOUSE_FILTER_IGNORE
				temp = 3
			3:
				Events.emit_signal("use_cutscene_1", "learn_3_off")
				mouse_filter = Control.MOUSE_FILTER_IGNORE
	pass # Replace with function body.
