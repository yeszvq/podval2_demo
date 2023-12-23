extends StaticBody2D

export var spec_object = ""
export var name_dialog_do = "" #Имя диалога_действия
export var name_dialog_do_1 = "" #Имя альтернативного диалога
export var name_dialog_no_item = "" #Имя диалога_отсутствия_предмета
export var name_dialog_null = "" #Имя диалога_выполненого_действия
export var name_need_item = "" #Имя предмета_условия
export var name_cutscene = "" #Имя катсцены
export var number_does_effect = 0 #Номер эффекта
export var id = 0
var near = false
var empty = false
var item = false
# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("changeemptytrue", self, "change_empty_true")
	Events.connect("changedoeseffect", self, "change_does_effect")
	pass # Replace with function body.


func _on_mouse_input_event(viewport, event, shape_idx):
	if Input.is_action_just_released("left_mouse_button") && near == true && Global.work_item == true:
		Events.emit_signal("handle_click_storage")
		if spec_object == "":
			if name_need_item != "":
				if name_cutscene != "" && name_dialog_do_1 == "":
					if Inventory.find_item_name(name_need_item) == -1:
						Events.emit_signal("start_dialogue", name_dialog_no_item)
					else:
						if empty == false:
							Events.emit_signal("use_cutscene", name_cutscene)
							empty = true
				elif name_dialog_do_1 != "" && name_cutscene != "":
					if Inventory.find_item_name(name_need_item) == -1:
						Events.emit_signal("start_dialogue", name_dialog_no_item)
					else:
						if empty == false:
							Events.emit_signal("use_cutscene", name_cutscene)
							empty = true
						else:
							Events.emit_signal("start_dialogue", name_dialog_null)
			else:
				if name_dialog_do_1 != "" && id == 0:
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
				elif id != 0:
					if number_does_effect != 0:
						if Inventory.does_effect.find(number_does_effect) == -1:
							Events.emit_signal("start_dialogue", name_dialog_do_1)
							return
						else:
							if empty == false:
								Events.emit_signal("start_dialogue", name_dialog_do)
								return
							if empty == true:
								Events.emit_signal("start_dialogue", name_dialog_null)
								return
					else:
						if empty == false:
							Events.emit_signal("start_dialogue", name_dialog_do)
							return
						else:
							Events.emit_signal("start_dialogue", name_dialog_null)
							return
				else:
					Events.emit_signal("start_dialogue", name_dialog_do)
					return
		else:
			match spec_object:
				"stol_v_pit_1":
					var temp = 0
					if temp == 0:
						Events.emit_signal("start_dialogue", "stol_v_pit_1")
						temp = 1
					elif temp == 1:
						if Inventory.find_item_name("sawpart") == -1:
							Events.emit_signal("start_dialogue", "stol_v_pit_1_no_item")
						else:
							Events.emit_signal("start_cutsene")
							temp = 2
					elif temp == 2:
						Events.emit_signal("start_dialogue", "stol_v_pit_1_null")
				#"blood_door_0":
				#	var temp = 0
				#	if Inventory.does_effect.find()
							
	pass # Replace with function body.

func _on_nearby_area_entered(area):
	near = true
	pass # Replace with function body.


func _on_nearby_area_exited(area):
	near = false
	pass # Replace with function body.
	
func change_empty_true(id_item):
	if id != 0 and int(id_item) == id:
		empty = true
	pass
	
func change_does_effect(id_effect):
	Inventory.does_effect.append(int(id_effect))
	pass
