extends StaticBody2D

var near = false
var empty = false


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("giltoneworked", self, "giltoneworked")
	pass # Replace with function body.

func giltoneworked():
	print("work")
	empty = true
	pass

func _on_mouse_input_event(viewport, event, shape_idx):
	if Input.is_action_just_released("left_mouse_button") && near == true && Global.work_item == true:
		Events.emit_signal("handle_click_storage")
		if empty == false:
			Events.emit_signal("start_dialogue", "giltone_chose")
		else:
			Events.emit_signal("start_dialogue", "giltone_null")
	pass # Replace with function body.


func _on_nearby_area_entered(area):
	near = true
	pass # Replace with function body.


func _on_nearby_area_exited(area):
	near = false
	pass # Replace with function body.
