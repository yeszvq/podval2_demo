extends StaticBody2D


var near = false
var empty = false

export var cutscene = ""
export var alt_dialog = ""
export var alt_dialog_1 = ""
export var need_item = ""
export var coordinates = []

func _ready():
	Events.connect("altarworked", self, "altarworked")
	pass # Replace with function body.

func altarworked():
	empty = true
	pass

func _on_open_input_event(viewport, event, shape_idx):
	if Input.is_action_just_released("left_mouse_button") && near == true && Global.work_item == true:
		Events.emit_signal("handle_click_storage")
		if empty == false:
			Events.emit_signal("start_dialogue", alt_dialog)
	pass # Replace with function body.


func _on_Area2D2_area_entered(area):
	near = true
	pass # Replace with function body.


func _on_Area2D2_area_exited(area):
	near = true
	pass # Replace with function body.


func use_open_door():
	Events.emit_signal("open_grid_door", coordinates)
	empty = true
	pass
	
func use_close_door():
	Events.emit_signal("close_grid_door", coordinates)
	empty = false
	pass
