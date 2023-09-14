extends PanelContainer

#Заметка для разработки
#Нужен скрипт для заполнения инвентаря
#Для этого ещё необходимо создать ноду которая будет шаблоном для вещей
#Что-то вроде ItemSlot как у меня было.






#переменные которые хранят пути узлов
var notepad_main_node
var shared_content = []



func _ready():
	#назначение переменных
	notepad_main_node = $MarginContainer/VBoxContainer/notepad_main_node
	#узел на который будут крепиться узла показывающие заметку 0
	shared_content.append($MarginContainer/VBoxContainer/notepad_main_node/PanelContainer/TextureRect/PanelContainer/MarginContainer/notes_node/VBoxContainer/VBoxContainer)
	#узел шаблон заметки - название 1
	shared_content.append($MarginContainer/VBoxContainer/notepad_main_node/PanelContainer/TextureRect/PanelContainer/MarginContainer/note_shablon/VBoxContainer/HBoxContainer/Label)
	#узел шаблон заметки - текст 2
	shared_content.append($MarginContainer/VBoxContainer/notepad_main_node/PanelContainer/TextureRect/PanelContainer/MarginContainer/note_shablon/VBoxContainer/Label)
	#кнопка назад с шаблона 3
	shared_content.append($MarginContainer/VBoxContainer/notepad_main_node/PanelContainer/TextureRect/PanelContainer/MarginContainer/note_shablon/VBoxContainer/HBoxContainer/back_note_shablon)
	#сам узел отвечающий за шаблон заметки 4
	shared_content.append($MarginContainer/VBoxContainer/notepad_main_node/PanelContainer/TextureRect/PanelContainer/MarginContainer/note_shablon)
	#узел к которому будут прикрепляться узлы показывающие предметы в инвентаре 5
	shared_content.append($MarginContainer/VBoxContainer/notepad_main_node/PanelContainer/TextureRect/PanelContainer/MarginContainer/inv_node/VBoxContainer/VBoxContainer)
	
	
	#функции при включение
	
	#подключение сигналов
	Events.connect("open_inventory", open_inventory)
	Events.connect("update_notebook", update_this_page_notebook)
	shared_content[3].pressed.connect(back_button_note)
	
	for i in get_tree().get_nodes_in_group("button_part_2"):
		i.gui_input.connect(action_tab_buttons.bind(i))
	pass

func _process(delta):
	$Label.text = str(Performance.get_monitor(Performance.TIME_FPS))
	pass

#нажатие на заметку
func note_button(event, name):
	var temp
	if event is InputEventMouseButton:
		if event.is_action_released("left_mouse"):
			temp = get_tree().get_nodes_in_group("notes_nodes").find(name)
			get_tree().get_first_node_in_group("node_ui_notebook").visible = false
			shared_content[1].text = Inventory.notes[temp]["name"]
			shared_content[2].text = Inventory.notes[temp]["desc"]
			shared_content[4].visible = true
	pass

#нажатие на кнопку обратно
func back_button_note():
	shared_content[4].visible = false
	get_tree().get_first_node_in_group("node_ui_notebook").visible = true
	pass

#функция нажатия на закладки блокнота
func action_tab_buttons(event, name):
	var index
	var temp
	if event is InputEventMouseButton:
		if event.is_action_released("left_mouse"):
			shared_content[4].visible = false
			temp = get_tree().get_nodes_in_group("button_part_1")
			index = get_tree().get_nodes_in_group("button_part_2").find(name)
			for i in temp:
				i.modulate.a = 0
			temp[index].modulate.a = 1
			temp = get_tree().get_nodes_in_group("node_ui_notebook")
			for i in temp:
				i.visible = false
			temp[index].visible = true
			content_generate(index)
	pass

#вызов функциия для обновления конкретной страницы
func update_this_page_notebook(index):
	content_generate(index)
	pass

#вызов нужной функции для обновления данных во ВСЕХ!!!!! страницах блокнота
func update_notebook():
	for i in 4:
			content_generate(i)
	pass

#функция для обновления и генерации контента на страницах
func content_generate(index):
	var temp
	var temp_2
	var temp_node
	match index:
		#заметки
		0:
			temp = get_tree().get_nodes_in_group("notes_nodes")
			temp_2 = Inventory.notes
			if temp.size() != Inventory.notes.size():
				if temp.size() < temp_2.size():
					for i in range(temp.size(), temp_2.size()):
						temp_node = preload("res://scene/menu/inventory_ui/label.tscn").instantiate()
						temp_node.text = str("- " + temp_2[i]["name"])
						shared_content[0].add_child(temp_node)
						temp_node.add_to_group("notes_nodes")
						temp_node.gui_input.connect(note_button.bind(temp_node))
						#print("БАги")
				#если будет происходить баг с тем что записок больше
				#то надо дописать скрипт, хотя такого бага я не встретил
				#так что доп условие пока писать не буду
				#но вкратце мы должны будем очистить тогда список заметок в узле
				#а потом заново его заполнить
		#инвентарь
		1:
			temp = get_tree().get_nodes_in_group("items_nodes")
			temp_2 = Inventory.count_inv() #здесь функция из Inventory, она возвращает число предметов которые есть
			if temp.size() != temp_2:
				if temp.size() < temp_2:
					for i in range(temp.size(), temp_2):
						temp_node = preload("res://scene/menu/inventory_ui/item_slot.tscn").instantiate()
						shared_content[5].add_child(temp_node)
						temp_node.add_to_group("items_nodes")
						temp_node.get_child(0).get_child(0).text = str("- " + Inventory.items[i]["name"])
						temp_node.get_child(0).get_child(1).texture = load("res://assets/sprite/items/" + Inventory.items[i]["icon"])
		#состояние
		2:
			temp = get_tree().get_nodes_in_group("status_bar")
			temp[0].value = Inventory.mind_pain[1]
			temp[2].value = Inventory.mind_pain[0]
			temp[1].text = str(Inventory.mind_pain[1])
			temp[3].text = str(Inventory.mind_pain[0])
		#карта
		#3:
			#print()
	pass


#открытие и закрытие инвентаря
func open_inventory():
	if notepad_main_node.visible == false:
		notepad_main_node.visible = true
		update_notebook()
	else:
		notepad_main_node.visible = false
	pass
