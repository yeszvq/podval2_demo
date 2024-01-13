extends PanelContainer

#переменные хранящие пути узлов
var notebook_path
var path_other = []

#переменные хранящие отличные от путей узлов типы
var page_number = 0
var dialogue = []

var last_node_dialog
var last_page = 1
var can_page = true


var last_string = ""
var read = false
var counts = 0
var active_0 = true
var audio
var playing_voice = false
var head = "hero"
var countsfs = 0
func _ready():
	visible = false
	audio = $AudioStreamPlayer
	#пути узлов
	notebook_path = $MarginContainer/VBoxContainer/notebook
	notebook_path.visible = false
	#нода за которую будут цепляться ноды отвечающие за заметки 0
	path_other.append($MarginContainer/VBoxContainer/notebook/TextureRect/MarginContainer/notebook_notes/MarginContainer/VBoxContainer)
	#нода отвечающая за шаблон развёрнутой заметки 1
	path_other.append($MarginContainer/VBoxContainer/notebook/TextureRect/MarginContainer/note_shablon)
	#нода отвечающая за название в шаблоне 2
	path_other.append($MarginContainer/VBoxContainer/notebook/TextureRect/MarginContainer/note_shablon/VBoxContainer/HBoxContainer/note_shablon_name)
	#нода отвечающая за текст в шаблоне 3
	path_other.append($MarginContainer/VBoxContainer/notebook/TextureRect/MarginContainer/note_shablon/VBoxContainer/note_shablon_content)
	#нода с списком заметок 4
	path_other.append($MarginContainer/VBoxContainer/notebook/TextureRect/MarginContainer/notebook_notes)
	#нода за которую будут цепляться ноды itemslot 5
	path_other.append($MarginContainer/VBoxContainer/notebook/TextureRect/MarginContainer/notebook_inventory/MarginContainer/VBoxContainer)
	#progress_bar и label отвечающие за heart 6/7
	path_other.append($MarginContainer/VBoxContainer/notebook/TextureRect/MarginContainer/notebook_status/VBoxContainer/HBoxContainer/VBoxContainer/heart_bar/VBoxContainer/TextureRect)
	path_other.append($MarginContainer/VBoxContainer/notebook/TextureRect/MarginContainer/notebook_status/VBoxContainer/HBoxContainer/VBoxContainer/heart_bar/VBoxContainer/Label)
	#progress_bar и label отвечающие за mind 8/9
	path_other.append($MarginContainer/VBoxContainer/notebook/TextureRect/MarginContainer/notebook_status/VBoxContainer/HBoxContainer/VBoxContainer/brain_bar/VBoxContainer/TextureRect)
	path_other.append($MarginContainer/VBoxContainer/notebook/TextureRect/MarginContainer/notebook_status/VBoxContainer/HBoxContainer/VBoxContainer/brain_bar/VBoxContainer/Label)
	
	#Пути для работы диалога
		#путь к самой ноде диалога 10
	path_other.append($MarginContainer/VBoxContainer/dialogue)
		#путь к изображению персонажа 11
	path_other.append($MarginContainer/VBoxContainer/dialogue/VBoxContainer/HBoxContainer/image/VBoxContainer/TextureRect)
		#путь к имени персонажа 12
	path_other.append($MarginContainer/VBoxContainer/dialogue/VBoxContainer/HBoxContainer/image/VBoxContainer/Label)
		#путь к тексту диалога 13
	path_other.append($MarginContainer/VBoxContainer/dialogue/VBoxContainer/HBoxContainer/Label)
	
	#Пути для работы выборов в диалоге
		#путь для открытия кнопок выбора в диалоге 14
	path_other.append($MarginContainer/dialog_chose)
		#путь к узлу к которому цепляются ноды для выбора 15
	path_other.append($MarginContainer/dialog_chose/VBoxContainer/PanelContainer/HBoxContainer/PanelContainer/MarginContainer/VBoxContainer)
		#Путь к текстуре карты 16
	path_other.append($MarginContainer/VBoxContainer/notebook/TextureRect/MarginContainer/notebook_map/VBoxContainer/TextureRect)
		#Путь к текстуре тела 17
	path_other.append($MarginContainer/VBoxContainer/notebook/TextureRect/MarginContainer/notebook_status/VBoxContainer/HBoxContainer/VBoxContainer2/TextureRect)
	
	#подключение сигналов
	Events.connect("open_notebook", self, "open_notebook")
	for i in get_tree().get_nodes_in_group("button_part_2"):
		i.connect("gui_input", self, "button_action", [i])
	Events.connect("update_hero", self, "update_hero")
	Events.connect("start_dialogue", self, "start_dialogue")
	Events.connect("map_new_list", self, "map_new_list")
	path_other[10].connect("gui_input", self, "update_dialogue")
	
	Events.connect("custom_dialog", self, "custom_dialog")
	Events.connect("notebook_hide", self, "notebook_hide")
	#Events.connect("pick_up_dialog_true", self, "pick_up_true")
	#Events.connect("pick_up_dialog_false", self, "pick_up_false")
	#Events.connect("pick_up_dialog_null", self, "pick_up_null")
	pass # Replace with function body.


func notebook_hide():
	notebook_path.visible = false
	pass

#пример строчки gosha#Гоша#Какое ахуенное яблоко.

#функция диалога подбора TRUE
#func pick_up_true(item):
	#custom_dialog("gosha#Гоша#Я подобрал" + item)
	#pass
#функция диалога подбора FALSE
#func pick_up_false():
	#custom_dialog("gosha#Гоша#Я не могу больше унести")
	#pass
#функция диалога подбора NULL
#func pick_up_null():
	#custom_dialog("gosha#Гоша#Тут пусто")
	#pass
	

func map_new_list(name_map):
	print("work_2")
	path_other[16].texture = load("res://assets/sprites/ui/new notebook/" + name_map + ".png")
	pass
	
#функция для кастомного диалога внутри кода
func custom_dialog(text):
	Events.emit_signal("start_dialog_for_hero")
	page_number = 0
	dialogue = []
	dialogue.append(text)
	visible = true
	path_other[10].visible = true
	update_dialogue()
	
	pass

func _process(delta):
	if read == true && active_0 == true:
		active_0 = false
		#print(last_string)
		if counts <= last_string.length() - 1:
			$MarginContainer/VBoxContainer/dialogue/VBoxContainer/HBoxContainer/Label.visible_characters = counts
			if last_string[counts] != " " && last_string[counts] != "":
				playing_voice = true
				voice()
			else:
				playing_voice = false
				voice()
			counts += 1
		else:
			playing_voice = false
			voice()
			read = false
			$Timer.start()
			counts = 0
	elif read == true && active_0 == false:
		if countsfs == 5:
			active_0 = true
			countsfs = 0
		else:
			countsfs = countsfs + 1
	pass
	
func voice():
	if playing_voice == false:
		$AudioStreamPlayer.stop()
		$AudioStreamPlayer.volume_db = -100
	else:
		$AudioStreamPlayer.volume_db = Global.last_volume_sound[1]
		$AudioStreamPlayer.play()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var temp = [0,0]
	match head:
		"cultist_1":
			temp[0] = 0.5
			temp[1] = 0.6
		"cultist_1_ahui":
			temp[0] = 0.5
			temp[1] = 0.6
		"cultist_2":
			temp[0] = 0.4
			temp[1] = 0.5
		_:
			temp[0] = 0.8 
			temp[1] = 0.9
	var random_float_number = rng.randf_range(temp[0], temp[1])
	$AudioStreamPlayer.pitch_scale = random_float_number
pass

#функция для продолжения диалога при клике по диалогу
func update_dialogue(event = null):
	if (event is InputEventMouseButton && event.is_action_released("left_mouse_button")) || event == null:
		#print("works")
		if read == true:
			playing_voice = false
			$AudioStreamPlayer.volume_db = -100
			read = false
			$MarginContainer/VBoxContainer/dialogue/VBoxContainer/HBoxContainer/Label.visible_characters = -1
		else:
			if page_number >= dialogue.size():
				Global.dialog = false
				path_other[10].visible = false
				#visible = false
				Events.emit_signal("end_dialog")
				mouse_filter = Control.MOUSE_FILTER_IGNORE
				return
			var temp = dialogue[page_number].split("#")
			if temp[temp.size() - 1].find("&") != -1:
				var temp_2 = temp[2].split("&")
				temp.remove(temp.size() - 1)
				temp.append(temp_2[0])
				temp_2.remove(0)
				var count = temp_2.size()
				var temp_3 = []
				for i in count:
					temp_3.append(temp_2[i].split("_"))
				temp_2 = []
				temp_2 = temp_3.duplicate(true)
				temp_3.clear()
				for i in temp_2:
					match i[0]:
						"close":
							page_number = 900
							path_other[10].visible = false
							visible = false
							Events.emit_signal("end_dialog")
						"addItem":
							Inventory.add_item(Global.items[i[1]])
						"removeItem":
							#Нужно доработать скрипт с удалением
							#for j in range(int(i[2])):
							Inventory.remove_item(Global.items[i[1]])
						"cutscene":
							Events.emit_signal("start_cutsene", i[1])
						"cutsceneCont":
							Events.emit_signal("use_start_cutscene")
						"signal":
							if i.size() == 3:
								Events.emit_signal(i[1], i[2])
							elif i.size() == 2:
								Events.emit_signal(i[1])
						"painchanged":
							Inventory.pain_mind_change(0, int(i[1]))
						"mindchanged":
							Inventory.pain_mind_change(1, int(i[1]))
						"quit":
							mouse_filter = Control.MOUSE_FILTER_IGNORE
							get_tree().quit()
			
			if temp[0] == "chose":
				#Нужно доработать этот скрипт
				#+++ Необходима чтобы каждая кнопка могла включать любое кол-во эффектов
				#+++ Необходимо, чтобы эффекты могли иметь несколько значений для addItem и removeItem
				path_other[14].visible = true
				path_other[15].add_child(preload("res://scene/object/control_expand_vertical.tscn").instance())
				for i in temp.size() - 1:
					var temp_button = preload("res://scene/object/button_chose.tscn").instance()
					var temp_2 = temp[i+1].split("||")
					temp_button.text = temp_2[0]
					temp_2.remove(0)
					var count = temp_2.size()
					var temp_3 = []
					for j in temp_2:
						temp_3.append(j.split("_"))
					temp_2 = temp_3
					temp_3 = []
					temp_button.connect("button_up", self, "button_chose_action", [temp_2])
					path_other[15].add_child(temp_button)
				path_other[15].add_child(preload("res://scene/object/control_expand_vertical.tscn").instance())
				page_number += 1
				path_other[10].visible = false
			else:
				counts = 0
				$MarginContainer/VBoxContainer/dialogue/VBoxContainer/HBoxContainer/Label.visible_characters = 0
				$AudioStreamPlayer.volume_db = Global.last_volume_sound[1]
				#$Timer.start()
				#print("Отдал")
				last_string = temp[2]
				#print(last_string)
				head = temp[0]
				path_other[11].texture = load("res://assets/sprites/characters/head/" + temp[0] + ".png")
				path_other[12].text = temp[1]
				path_other[13].text = temp[2]
				page_number += 1
				read = true
	pass

#функция при нажатия на кнопки выбора в диалогах
func button_chose_action(value = null):
	Events.emit_signal("start_sound", "ui_click")
	var temp = []
	for i in value:
		match i[0]:
			"addItem":
				Inventory.add_item(Global.items[i[1]])
				path_other[13].text = str("Я подобрал " + Global.items[i[1]]["name"].to_lower())
				path_other[10].visible = true
			"nothing":
				path_other[13].text = str("Я просто отойду")
				path_other[10].visible = true
			"remove":
				#нужно доработать скрипт с удалением
				Inventory.remove_item(Global.items[i[1]])
			"cutscene":
				Events.emit_signal("use_cutscene", i[1])
			"close":
				page_number = 900
				path_other[10].visible = false
				visible = false
				mouse_filter = Control.MOUSE_FILTER_IGNORE
				Events.emit_signal("end_dialog")
			"signal":
				Events.emit_signal(i[1],i[2])
	path_other[14].visible = false
	var temp_2 = path_other[15].get_children()
	for i in range(1, temp_2.size()):
		path_other[15].remove_child(temp_2[i])
	pass

#диалог
func start_dialogue(name_path):
	mouse_filter = Control.MOUSE_FILTER_STOP
	Global.dialog = true
	page_number = 0
	#открываем файл и считываем с него информацию
	var temp = str("res://assets/dialogue/" + name_path + ".txt")
	var file = File.new()
	file.open(temp, File.READ)
	temp = file.get_as_text()
	file.close()
	notebook_path.visible = false
	dialogue = temp.split("\n")
	update_dialogue()
	path_other[10].visible = true
	visible = true
	pass


#функция при обновлений значений инвентаря
func update_hero(index):
	generate_content(index)

#функция подробного открытия записки
func open_note(event, index):
	if event is InputEventMouseButton:
		if event.is_action_released("left_mouse_button"):
			path_other[4].visible = false
			path_other[1].visible = true
			path_other[2].text = Inventory.notes[index]["name"]
			path_other[3].text = Inventory.notes[index]["desc"]
	pass

#действие при нажатии на закладку
func button_action(event, name):
	if event is InputEventMouseButton:
		if event.is_action_released("left_mouse_button") && can_page == true:
			var temp = str(name).split(":")
			temp = temp[0].split("_")
			for i in get_tree().get_nodes_in_group("button_part_1"):
				var temp_2 = str(i).split(":")
				temp_2 = temp_2[0].split("_")
				if temp[3] == temp_2[3]:
					i.modulate.a8 = 255
				else:
					i.modulate.a8 = 0
			generate_content(int(temp[3]) - 1)
			var temp_2 = 0
			for i in get_tree().get_nodes_in_group("notebook_content_page"):
					if temp_2 == int(temp[3]) - 1:
						i.visible = true
					else:
						i.visible = false
					temp_2 += 1
			if last_page != int(temp[3]):
				last_page = int(temp[3])
				Events.emit_signal("start_sound", "notebook")
				can_page = false
				$Timer2.start()
				match int(temp[3]):
					1:
						$MarginContainer/VBoxContainer/notebook/TextureRect.texture = load("res://assets/sprites/ui/new notebook/osnova_note.png")
					2:
						$MarginContainer/VBoxContainer/notebook/TextureRect.texture = load("res://assets/sprites/ui/new notebook/osnova_inv.png")
					3:
						$MarginContainer/VBoxContainer/notebook/TextureRect.texture = load("res://assets/sprites/ui/new notebook/osnova_status.png")
					4:
						$MarginContainer/VBoxContainer/notebook/TextureRect.texture = load("res://assets/sprites/ui/new notebook/osnova_map.png")
			
	pass

#генерация контента
func generate_content(index):
	match index:
		#заметки
		0:
			var temp_2 = path_other[0].get_children()
			for i in range(1, temp_2.size()):
				path_other[0].remove_child(temp_2[i])
			var temp = get_tree().get_nodes_in_group("notes_nodes")
			temp_2 = Inventory.notes
			if temp.size() != Inventory.notes.size():
				if temp.size() < temp_2.size():
					for i in range(temp.size(), temp_2.size()):
						var temp_node = preload("res://scene/ui/note_1.tscn").instance()
						temp_node.text = str("- " + temp_2[i]["name"])
						path_other[0].add_child(temp_node)
		#инвентарь
		1:
			#Здесь мы отчищаем список нод itemslot, чтобы нормально отобразить существующие.
			#Мне лень было делать отдельную функцию для поиска и удаления ноды
			var temp_2 = path_other[5].get_children()
			for i in range(1, temp_2.size()):
				path_other[5].remove_child(temp_2[i])
			var temp = Inventory.count_inv() #здесь функция из Inventory, она возвращает число предметов которые есть
			for i in range(0, temp):
				var temp_node = preload("res://scene/ui/itemslot.tscn").instance()
				path_other[5].add_child(temp_node)
				temp_node.connect("gui_input", self, "action_with_item", [i])
				#temp_node.add_to_group("items_nodes")
				temp_node.get_child(0).get_child(0).text = str("- " + Inventory.items[i]["name"])
				#temp_node.get_child(0).get_child(1).texture = load("res://assets/sprites/items/" + Inventory.items[i]["icon"])
		#статус
		2:
			#print(Inventory.pain_mind[1])
			#боль
			if Inventory.pain_mind[0] <= 100 && Inventory.pain_mind[0] > 90:
				path_other[6].texture = load("res://assets/sprites/ui/heart/100.png")
			elif Inventory.pain_mind[0] <= 90 && Inventory.pain_mind[0] > 80:
				path_other[6].texture = load("res://assets/sprites/ui/heart/90.png")  
			elif Inventory.pain_mind[0] <= 80 && Inventory.pain_mind[0] > 70:
				path_other[6].texture = load("res://assets/sprites/ui/heart/80.png") 
			elif Inventory.pain_mind[0] <= 70 && Inventory.pain_mind[0] > 60:
				path_other[6].texture = load("res://assets/sprites/ui/heart/70.png")  
			elif Inventory.pain_mind[0] <= 60 && Inventory.pain_mind[0] > 50:
				path_other[6].texture = load("res://assets/sprites/ui/heart/60.png")  
			elif Inventory.pain_mind[0] <= 50 && Inventory.pain_mind[0] > 30:
				path_other[6].texture = load("res://assets/sprites/ui/heart/50.png") 
			elif Inventory.pain_mind[0] <= 30 && Inventory.pain_mind[0] > 20:
				path_other[6].texture = load("res://assets/sprites/ui/heart/30.png") 
			elif Inventory.pain_mind[0] <= 20 && Inventory.pain_mind[0] > 10:
				path_other[6].texture = load("res://assets/sprites/ui/heart/20.png") 
			elif Inventory.pain_mind[0] <= 10 && Inventory.pain_mind[0] > 5:
				path_other[6].texture = load("res://assets/sprites/ui/heart/10.png") 
			elif Inventory.pain_mind[0] <= 5 && Inventory.pain_mind[0] >= 0 :
				path_other[6].texture = load("res://assets/sprites/ui/heart/0.png")
				
			if Inventory.pain_mind[1] <= 100 && Inventory.pain_mind[1] > 90:
				path_other[8].texture = load("res://assets/sprites/ui/mind/100.png")
			elif Inventory.pain_mind[1] <= 90 && Inventory.pain_mind[1] > 80:
				path_other[8].texture = load("res://assets/sprites/ui/mind/90.png")  
			elif Inventory.pain_mind[1] <= 80 && Inventory.pain_mind[1] > 60:
				path_other[8].texture = load("res://assets/sprites/ui/mind/80.png")
			elif Inventory.pain_mind[1] <= 60 && Inventory.pain_mind[1] > 50:
				path_other[8].texture = load("res://assets/sprites/ui/mind/60.png")  
			elif Inventory.pain_mind[1] <= 50 && Inventory.pain_mind[1] > 30:
				path_other[8].texture = load("res://assets/sprites/ui/mind/50.png")
			elif Inventory.pain_mind[1] <= 30 && Inventory.pain_mind[1] > 20:
				path_other[8].texture = load("res://assets/sprites/ui/mind/30.png")
			elif Inventory.pain_mind[1] <= 20 && Inventory.pain_mind[1] > 10:
				path_other[8].texture = load("res://assets/sprites/ui/mind/20.png")
			elif Inventory.pain_mind[1] <= 10 && Inventory.pain_mind[1] > 5:
				path_other[8].texture = load("res://assets/sprites/ui/mind/10.png")
			elif Inventory.pain_mind[1] <= 5 && Inventory.pain_mind[1] >= 0 :
				path_other[8].texture = load("res://assets/sprites/ui/mind/0.png")
			#path_other[6].value = Inventory.pain_mind[0]
			#path_other[7].text = str(Inventory.pain_mind[0])
			#path_other[8].value = Inventory.pain_mind[1]
			#path_other[9].text = str(Inventory.pain_mind[1])
			
			var temp = Inventory.get_body()
			#print(temp)
			temp = (
				"normal" if temp == "none"
				else "legs" if temp == "legs"
				else "arm" if temp == "arm"
				else "legs_arm" if temp == "legs_arm"
				else "normal"
			)
			#print(temp)
			path_other[17].texture = load("res://assets/sprites/ui/new notebook/body_" + temp + ".png")
		#карта
		#3:
		#	print()
	pass


#функция взаимодействия с предметами в инвентаре
#func action_with_item(event, index = 0):
#	if event is InputEventMouseButton:
#		if event.is_action_released("left_mouse_button"):
#			use_item(Inventory.find_item_index(index))
#			if Inventory.find_item_index(index)["effect"] != "null":
#				Inventory.remove_item_index(index)
#		elif event.is_action_released("right_mouse_button"):
#			var item = Inventory.find_item_index(index)
#			Inventory.remove_item_index(index)
#			Events.emit_signal("drop_item", item)
#	pass
	
	
#функция эффектов от предметов
#func use_item(item):
#	match item["effect"]:
#		"heal":
#			Inventory.pain_mind_change(0, -20)
#		"mind":
#			Inventory.pain_mind_change(1, 35)
#	pass
	
#функция при нажатии кнопки Tab
func open_notebook():
	if notebook_path.visible == false:
		generate_content(0)
		visible = true
		notebook_path.visible = true
	else:
		visible = false
		notebook_path.visible = false
	pass

#сигнал который отвечает за нажатие кнопки назад на самой развёрнутой заметке
func _on_TextureRect_gui_input(event):
	path_other[1].visible = false
	path_other[4].visible = true
	pass # Replace with function body.


func _on_Timer_timeout():
	update_dialogue()
	$Timer.stop()
	pass # Replace with function body.


func _on_Timer2_timeout():
	can_page = true
	pass # Replace with function body.


func _on_Timer3_timeout():
	active_0 = true
	pass # Replace with function body.


func _on_HUD_gui_input(event):
	if event is InputEventMouseButton && event.is_action_released("left_mouse_button") && Global.dialog == true:
		#print('work')
		update_dialogue()
	pass # Replace with function body.
