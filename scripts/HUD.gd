extends PanelContainer

#переменные хранящие пути узлов
var notebook_path
var path_other = []

#переменные хранящие отличные от путей узлов типы
var page_number = 0
var dialogue


func _ready():
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
	
	
	#подключение сигналов
	Events.connect("open_notebook", self, "open_notebook")
	for i in get_tree().get_nodes_in_group("button_part_2"):
		i.connect("gui_input", self, "button_action", [i])
	Events.connect("update_hero", self, "update_hero")
	Events.connect("start_dialogue", self, "start_dialogue")
	path_other[10].connect("gui_input", self, "update_dialogue")
	pass # Replace with function body.

func update_dialogue(event = null):
	if (event is InputEventMouseButton && event.is_action_released("left_mouse_button")) || event == null:
		if page_number == dialogue.size():
			path_other[10].visible = false
			Events.emit_signal("end_dialog")
			return
		var temp = dialogue[page_number].split("#")
		path_other[11].texture = load("res://assets/sprites/characters/head/" + temp[0] + ".png")
		path_other[12].text = temp[1]
		path_other[13].text = temp[2]
		page_number += 1
	pass


#диалог
func start_dialogue(name_path):
	#открываем файл и считываем с него информацию
	var temp = str("res://assets/dialogue/" + name_path + ".txt")
	print(temp)
	var file = File.new()
	file.open(temp, File.READ)
	temp = file.get_as_text()
	file.close()
	notebook_path.visible = false
	dialogue = temp.split("\n")
	update_dialogue()
	path_other[10].visible = true
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
			var temp = get_tree().get_nodes_in_group("items_nodes")
			var temp_2 = Inventory.count_inv() #здесь функция из Inventory, она возвращает число предметов которые есть
			if temp.size() != temp_2:
				if temp.size() < temp_2:
					for i in range(temp.size(), temp_2):
						var temp_node = preload("res://scene/ui/itemslot.tscn").instance()
						path_other[5].add_child(temp_node)
						temp_node.add_to_group("items_nodes")
						print(temp_node.get_child(0).get_children())
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

#функция при нажатии кнопки Tab
func open_notebook():
	if notebook_path.visible == false:
		generate_content(0)
		notebook_path.visible = true
	else:
		notebook_path.visible = false
	pass

#сигнал который отвечает за нажатие кнопки назад на самой развёрнутой заметке
func _on_TextureRect_gui_input(event):
	path_other[1].visible = false
	path_other[4].visible = true
	pass # Replace with function body.
