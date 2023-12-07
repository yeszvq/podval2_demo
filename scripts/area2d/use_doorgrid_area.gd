extends StaticBody2D

var empty = false
var near = false
export var coordinates = []

func _ready():
	pass # Replace with function body.



func _on_Area2D2_area_entered(area):
	near = true
	pass # Replace with function body.


func _on_Area2D2_area_exited(area):
	near = false
	pass # Replace with function body.


func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_just_released("left_mouse_button") && near == true:
		Events.emit_signal("handle_click_storage")
		if empty == false:
			print("открываю дверь")
			Events.emit_signal("open_grid_door", coordinates)
			empty = true
		elif empty == true:
			Events.emit_signal("close_grid_door", coordinates)
			empty = false
	pass # Replace with function body.


func _on_open_input_event(viewport, event, shape_idx):
	if Input.is_action_just_released("left_mouse_button") && near == true:
		Events.emit_signal("handle_click_storage")
		if empty == false:
			print("открываю дверь")
			Events.emit_signal("open_grid_door", coordinates)
			empty = true
	pass # Replace with function body.


func _on_close_input_event(viewport, event, shape_idx):
	if Input.is_action_just_released("left_mouse_button") && near == true:
		Events.emit_signal("handle_click_storage")
		if empty == true:
			Events.emit_signal("close_grid_door", coordinates)
			empty = false
	pass # Replace with function body.
