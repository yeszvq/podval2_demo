extends StaticBody2D

var near = false
var empty = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_mouse_input_event(viewport, event, shape_idx):
	if Input.is_action_just_released("left_mouse_button") && near == true && Global.work_item == true:
		Events.emit_signal("handle_click_storage")
		if empty == false:
			Events.emit_signal("custom_dialog", "gosha#Гоша#Я достал камень из дыры в стене")
			Inventory.add_item(Global.items["rock"])
			empty = true
		else:
			Events.emit_signal("custom_dialog", "gosha#Гоша#В этой дыре больше ничего нет")
	pass # Replace with function body.


func _on_near_area_entered(area):
	near = true
	pass # Replace with function body.


func _on_near_area_exited(area):
	near = false
	pass # Replace with function body.
