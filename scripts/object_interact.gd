extends StaticBody2D

export var alt_dialog = false #Включение этой фунции
export var name_dialog = "" #Имя основого диалога ОБЯЗАТЕЛЬНО
export var name_alt_dialog_0 = "" #Имя альтернативного диалога
export var name_alt_dialog_1 = "" #Имя второго альтернативного диалога
export var need_item = false #Включение этой функции
export var name_need_item = "" #Имя предмета
export var cutscene = false
export var name_cutscene = ""
var near = false
var empty = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_mouse_input_event(viewport, event, shape_idx):
	if Input.is_action_just_released("left_mouse_button") && near == true && Global.work_item == true:
		Events.emit_signal("handle_click_storage")
		if alt_dialog == false:
			Events.emit_signal("start_dialogue", name_dialog)
		elif alt_dialog == true:
			if need_item == false:
				if empty == false:
					Events.emit_signal("start_dialogue", name_dialog)
					empty = true
				else:
					Events.emit_signal("start_dialogue", name_alt_dialog_0)
			elif need_item == true:
				if cutscene == true:
					if empty == false:
						if Inventory.find_item_name(name_need_item) == -1:
							Events.emit_signal("start_dialogue", name_alt_dialog_0)
						else:
							Events.emit_signal("use_cutscene", name_cutscene)
							empty = true
					else:
						Events.emit_signal("start_dialogue", name_alt_dialog_1)
				else:
					if empty == false:
						if Inventory.find_item_name(name_need_item) == -1:
							Events.emit_signal("start_dialogue", name_alt_dialog_0)
						else:
							Events.emit_signal("start_dialogue", name_dialog)
							empty = true
					else:
						Events.emit_signal("start_dialogue", name_alt_dialog_1)
				
	pass # Replace with function body.


func _on_nearby_area_entered(area):
	near = true
	pass # Replace with function body.


func _on_nearby_area_exited(area):
	near = false
	pass # Replace with function body.
