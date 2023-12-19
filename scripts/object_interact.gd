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
var item = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_mouse_input_event(viewport, event, shape_idx):
	if Input.is_action_just_released("left_mouse_button") && near == true && Global.work_item == true:
		Events.emit_signal("handle_click_storage")
		if name_need_item != "":
			if Inventory.find_item_name(name_need_item) == -1:
				Events.emit_signal("start_dialogue", name_dialog_no_item)
			else:
				if empty == false:
					Events.emit_signal("use_cutscene", name_cutscene)
					empty = true
		else:
			if name_dialog_do_1 != "":
				if name_cutscene != "":
					if empty == false:
						Events.emit_signal("use_cutscene", name_cutscene)
						empty = true
					else:
						Events.emit_signal("start_dialogue", name_dialog_do_1)
				else:
					if empty == false:
						Events.emit_signal("start_dialogue", name_dialog_do)
						empty = true
					else:
						Events.emit_signal("start_dialogue", name_dialog_do_1)
			else:
				Events.emit_signal("start_dialogue", name_dialog_do)
	pass # Replace with function body.


func _on_nearby_area_entered(area):
	near = true
	pass # Replace with function body.


func _on_nearby_area_exited(area):
	near = false
	pass # Replace with function body.
