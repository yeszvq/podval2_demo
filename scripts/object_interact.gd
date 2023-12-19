extends StaticBody2D

export var name_dialog_do = "" #Имя диалога_действия
export var name_dialog_do_1 = "" #Имя альтернативного диалога
export var name_dialog_no_item = "" #Имя диалога_отсутствия_предмета
export var name_dialog_null = "" #Имя диалога_выполненого_действия
export var name_need_item = "" #Имя предмета_условия
export var name_cutscene = "" #Имя катсцены
export var number_does_effect = 0 #Номер эффекта
var near = false
var empty = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_mouse_input_event(viewport, event, shape_idx):
	if Input.is_action_just_released("left_mouse_button") && near == true && Global.work_item == true:
		Events.emit_signal("handle_click_storage")
	pass # Replace with function body.


func _on_nearby_area_entered(area):
	near = true
	pass # Replace with function body.


func _on_nearby_area_exited(area):
	near = false
	pass # Replace with function body.
