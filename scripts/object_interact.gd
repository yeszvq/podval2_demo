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
var temp = 0
var respawn = false
# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("changeemptytrue", self, "change_empty_true")
	Events.connect("changedoeseffect", self, "change_does_effect")
	Events.connect("changetemp", self, "change_temp")
	Events.connect("respawn", self, "respawn_func")
	pass # Replace with function body.

func respawn_func():
	respawn = true
	pass

func _on_mouse_input_event(viewport, event, shape_idx):
	if Input.is_action_just_released("left_mouse_button") && near == true && Global.work_item == true:
		Events.emit_signal("handle_click_storage")
		Events.emit_signal("walk_stop")
		if Global.dialog != true && Global.cutscene != true:
			if spec_object == "":
				if name_need_item != "":
					if name_cutscene != "" && name_dialog_null == "":
						if Inventory.find_item_name(name_need_item) == -1:
							Events.emit_signal("start_dialogue", name_dialog_no_item)
						else:
							if empty == false:
								Events.emit_signal("use_cutscene", name_cutscene)
								empty = true
					elif name_dialog_null != "" && name_cutscene != "":
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
					"gora_storages":
						if respawn == false:
							if temp == 0:
								Events.emit_signal("start_dialogue", "storages_in_sclad")
								temp = 1
							else:
								Events.emit_signal("start_dialogue", "storages_in_sclad_null")
						else:
							Events.emit_signal("start_dialogue", "storages_in_sclad_null")
					"bochka":
						if respawn == false || (respawn == true && Inventory.memory[2] == false):
							if temp == 0:
								if Inventory.find_item_name("deadRat") == -1:
									Events.emit_signal("start_dialogue", "bochka_no_item")
								else:
									Events.emit_signal("use_cutscene", "bochka_work")
									Inventory.memory[2] = true
									temp = 1
					"stol_verstak":
						if respawn == false || (respawn == true && Inventory.memory[1] == false):
							if temp == 0:
								Events.emit_signal("start_dialogue", "stol_verstak")
								Inventory.memory[1] = true
								temp = 1
							else:
								Events.emit_signal("stol_verstak_null")
						else:
							Events.emit_signal("start_dialogue", "stol_verstak_null")
					"holodos":
						if respawn == false || (respawn == true && Inventory.memory[0] == false):
							if temp == 0:
								Events.emit_signal("use_cutscene", "holodos_osmotr")
								Inventory.memory[0] = true
								temp = 1
							else:
								Events.emit_signal("start_dialogue", "holodos_v_pit_do_1")
						else:
							Events.emit_signal("start_dialogue", "holodos_v_pit_do_1")
					"stol_v_pit_0":
						if respawn == false:
							if Inventory.does_effect.find(1) == -1:
								Events.emit_signal("start_dialogue", "stol_v_pit_0")
							else:
								Events.emit_signal("start_dialogue", "stol_v_pit_0_1")
						else:
							Events.emit_signal("start_dialogue", "stol_v_pit_0_1")
					"stol_v_pit_1":
						if respawn == false:
							if temp == 0:
								Events.emit_signal("start_dialogue", "stol_v_pit_1")
								Events.emit_signal("custom_one_change", Vector2(27,-9), 120)
								temp = 1
							else:
								Events.emit_signal("start_dialogue", "stol_v_pit_1_null")
						else:
							Events.emit_signal("start_dialogue", "stol_v_pit_1_null")
					"camen_in_wall":
						if respawn == false:
							if temp == 0:
								Events.emit_signal("start_dialogue", "camen_in_wall_do")
								temp = 1
							else:
								Events.emit_signal("start_dialogue", "camen_in_wall_do_1")
						else:
							Events.emit_signal("start_dialogue", "camen_in_wall_do_1")
					"blood_door_0":
						if respawn == false:
							if temp == 0:
								if Inventory.find_item_name("arm") == -1:
									if Inventory.does_effect.find(1) == -1:
										Events.emit_signal("start_dialogue", "blood_door_0_no_item_0")
									else:
										Events.emit_signal("start_dialogue", "blood_door_0_no_item_1")
								else:
									Events.emit_signal("use_cutscene", "blood_door_0_work")
									temp = 1
					"trup":
						if respawn == false:
							if temp == 0:
								if Inventory.find_item_name("saw") == -1:
									Events.emit_signal("start_dialogue", "trup_no_item")
								else:
									Events.emit_signal("use_cutscene", "trup_work")
									temp = 1
					"giltone":
						if temp == 0:
							Events.emit_signal("start_dialogue", "giltone_no_item")
						elif temp == 1:
							Events.emit_signal("start_dialogue", "giltone_do_1")
							Events.emit_signal("custom_one_change", Vector2(44,-62), 132)
					"altar":
						if temp == 0:
							if Inventory.find_item_name("armGosha") == -1:
								Events.emit_signal("start_dialogue", "altar_no_item")
							else:
								Events.emit_signal("use_cutscene", "altar_work")
								temp = 1
						elif temp == 1:
							Events.emit_signal("start_dialogue", "altar_null")
					"end_door":
						#Events.emit_signal("end_game")
						if temp == 0:
							Events.emit_signal("start_dialogue", "end_door")
						elif temp == 1:
							Events.emit_signal("use_cutscene", "end")
					"end_stol":
						if temp == 0:
							Events.emit_signal("start_dialogue", "end_stol")
							Events.emit_signal("end_stol_change")
							temp = 1
						else:
							Events.emit_signal("start_dialogue", "end_stol_null")
					"door_verstak":
						if respawn == false:
							if temp == 0:
								if Inventory.find_item_name("crowbar") == -1:
									Events.emit_signal("start_dialogue", "door_verstak_no_item")
								else:
									Events.emit_signal("use_cutscene", "door_verstak_break")
									temp = 1
					"verstak":
						if respawn == false:
							if temp == 0:
								if Inventory.find_item_name("sawpart") == -1:
									Events.emit_signal("start_dialogue", "verstak")
								else:
									Events.emit_signal("use_cutscene", "verstak_work")
									temp = 1
							else:
								Events.emit_signal("start_dialogue", "verstak_null")
						else:
							Events.emit_signal("start_dialogue", "verstak_null")
		Events.emit_signal("walk_stop")
	pass # Replace with function body.

func _on_nearby_area_entered(area):
#	Events.emit_signal("show_i")
	near = true
	pass # Replace with function body.


func _on_nearby_area_exited(area):
#	Events.emit_signal("hide_i")
	near = false
	pass # Replace with function body.
	
func change_empty_true(id_item):
	if id != 0 and int(id_item) == id:
		empty = true
	pass
	
func change_temp(id_item):
	if id != 0 and int(id_item) == id:
		temp = temp + 1
	pass
	pass
	
func change_does_effect(id_effect):
	Inventory.does_effect.append(int(id_effect))
	pass
