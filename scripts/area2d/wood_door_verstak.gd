extends StaticBody2D

var near = false
var empty = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_nearby_area_entered(area):
	near = true
	pass # Replace with function body.


func _on_nearby_area_exited(area):
	near = false
	pass # Replace with function body.


func _on_mouse_input_event(viewport, event, shape_idx):
	if Input.is_action_just_released("left_mouse_button") && near == true && Global.work_item == true:
		Events.emit_signal("handle_click_storage")
		if empty == false:
			if Inventory.find_item_name("crowbar") == -1:
				Events.emit_signal("start_dialogue", "wood_door_verstak_no_item")
			else:
				Events.emit_signal("use_cutscene", "broke_wood_door")
				empty = true
	pass # Replace with function body.
