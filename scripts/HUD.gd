extends PanelContainer

#переменные хранящие пути узлов
var notebook_path
var path_other = []

#переменные хранящие отличные от путей узлов типы
var page_number = 0
var dialogue = []

var last_node_dialog


func _ready():
	visible = false
	#пути узлов
	notebook_path = $MarginContainer/VBoxContainer/notebook
	notebook_path.visible = false
	#нода за которую будут цепляться ноды отвечающие за заметки 0
	path_other.append($MarginContainer/VBoxContainer/notebook/TextureRect/MarginContainer/notebook_notes/VBoxContainer)
	#нода отвечающая за шаблон развёрнутой заметки 1
	path_other.append($MarginContainer/VBoxContainer/notebook/TextureRect/MarginContainer/note_shablon)
	#нода отвечающая за название в шаблоне 2
	path_other.append($MarginContainer/VBoxContainer/notebook/TextureRect/MarginContainer/note_shablon/VBoxContainer/HBoxContainer/note_shablon_name)
	#нода отвечающая за текст в шаблоне 3
	path_other.append($MarginContainer/VBoxContainer/notebook/TextureRect/MarginContainer/note_shablon/VBoxContainer/note_shablon_content)
	#нода с списком заметок 4
	path_other.append($MarginContainer/VBoxContainer/notebook/TextureRect/MarginContainer/notebook_notes)
	#нода за которую будут цепляться ноды itemslot 5
	path_other.append($MarginContainer/VBoxContainer/notebook/TextureRect/MarginContainer/notebook_inventory/VBoxContainer)
	#progress_bar и label отвечающие за heart 6/7
	path_other.append($MarginContainer/VBoxContainer/notebook/TextureRect/MarginContainer/notebook_status/VBoxContainer/HBoxContainer/VBoxContainer/heart_bar/VBoxContainer/TextureProgress)
	path_other.append($MarginContainer/VBoxContainer/notebook/TextureRect/MarginContainer/notebook_status/VBoxContainer/HBoxContainer/VBoxContainer/heart_bar/VBoxContainer/Label)
	#progress_bar и label отвечающие за mind 8/9
	path_other.append($MarginContainer/VBoxContainer/notebook/TextureRect/MarginContainer/notebook_status/VBoxContainer/HBoxContainer/VBoxContainer/brain_bar/VBoxContainer/TextureProgress)
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
	
	#подключение сигналов
	Events.connect("open_notebook", self, "open_notebook")
	for i in get_tree().get_nodes_in_group("button_part_2"):
		i.connect("gui_input", self, "button_action", [i])
	Events.connect("update_hero", self, "update_hero")
	Events.connect("start_dialogue", self, "start_dialogue")
	path_other[10].connect("gui_input", self, "update_dialogue")
	
	Events.connect("custom_dialog", self, "custom_dialog")
	#Events.connect("pick_up_dialog_true", self, "pick_up_true")
	#Events.connect("pick_up_dialog_false", self, "pick_up_false")
	#Events.connect("pick_up_dialog_null", self, "pick_up_null")
	pass # Replace with function body.


#пример строчки gosha#Гоша#Какое ахуенное яблоко.

#функция диалога подбора TRUE
#func pick_up_true(item):
	#print("work")
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

#функция для продолжения диалога при клике по диалогу
func update_dialogue(event = null):
	if (event is InputEventMouseButton && event.is_action_released("left_mouse_button")) || event == null:
		if page_number >= dialogue.size():
			path_other[10].visible = false
			visible = false
			Events.emit_signal("end_dialog")
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
						Events.emit_signal(i[1])
					"painchanged":
						Inventory.pain_mind_change(0, int(i[1]))
					"mindchanged":
						Inventory.pain_mind_change(1, int(i[1]))
		
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
			$Timer.start()
			path_other[11].texture = load("res://assets/sprites/characters/head/" + temp[0] + ".png")
			path_other[12].text = temp[1]
			path_other[13].text = temp[2]
			page_number += 1
	pass

#функция при нажатия на кнопки выбора в диалогах
func button_chose_action(value = null):
	match value[0][0]:
		"addItem":
			Inventory.add_item(Global.items[value[1][0]])
			path_other[13].text = str("Я подобрал " + Global.items[value[1][0]]["name"].to_lower())
			path_other[10].visible = true
		"nothing":
			path_other[13].text = str("Я просто отойду")
			path_other[10].visible = true
		"remove":
			#нужно доработать скрипт с удалением
			Inventory.remove_item(Global.items[value[1][0]])
		"cutscene":
			Events.emit_signal("use_cutscene", value[1][0])
		"close":
			page_number = 900
			path_other[10].visible = false
			visible = false
			Events.emit_signal("end_dialog")
	path_other[14].visible = false
	var temp_2 = path_other[15].get_children()
	for i in range(1, temp_2.size()):
		path_other[15].remove_child(temp_2[i])
	pass

#диалог
func start_dialogue(name_path):
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
		if event.is_action_released("left_mouse_button"):
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
	pass

#генерация контента
func generate_content(index):
	match index:
		#заметки
		0:
			var temp = get_tree().get_nodes_in_group("notes_nodes")
			var temp_2 = Inventory.notes
			if temp.size() != Inventory.notes.size():
				if temp.size() < temp_2.size():
					for i in range(temp.size(), temp_2.size()):
						var temp_node = preload("res://scene/ui/note_1.tscn").instance()
						temp_node.text = str("- " + temp_2[i]["name"])
						path_other[0].add_child(temp_node)
						temp_node.connect("gui_input", self, "open_note", [i])
						temp_node.add_to_group("notes_nodes")
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
				temp_node.get_child(0).get_child(1).texture = load("res://assets/sprites/items/" + Inventory.items[i]["icon"])
		#статус
		2:
			path_other[6].value = Inventory.pain_mind[0]
			path_other[7].text = str(Inventory.pain_mind[0])
			path_other[8].value = Inventory.pain_mind[1]
			path_other[9].text = str(Inventory.pain_mind[1])
		#карта
		3:
			print()
	pass


#функция взаимодействия с предметами в инвентаре
func action_with_item(event, index = 0):
	if event is InputEventMouseButton:
		if event.is_action_released("left_mouse_button"):
			use_item(Inventory.find_item_index(index))
			if Inventory.find_item_index(index)["effect"] != "null":
				Inventory.remove_item_index(index)
		elif event.is_action_released("right_mouse_button"):
			var item = Inventory.find_item_index(index)
			Inventory.remove_item_index(index)
			Events.emit_signal("drop_item", item)
	pass
	
	
#функция эффектов от предметов
func use_item(item):
	match item["effect"]:
		"heal":
			Inventory.pain_mind_change(0, -20)
		"mind":
			Inventory.pain_mind_change(1, 35)
	pass
	
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
	pass # Replace with function body.
