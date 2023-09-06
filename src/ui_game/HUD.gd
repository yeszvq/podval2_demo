extends Control
#Файл, который в целом контролирует поведение интерфейса

#переменные отвечающие за работу ячеек инвентаря
var active_itemslot


#переменные для удобного открытия интерфейса инвентаря
var buttons_typemenu
var all_grid_inv
var type_slot
var actionButtons
var pain_bar
var mind_bar
var pain_bar_text
var notes_main
var scroll_conteiner
var button_back_notes
var notes_shablon


#эти перменные нужны для корректировки выделения кнопок
#в каждом из массивов 0 - typemenu 1 - typeslot
var focus_texture = [preload("res://assets/sprite/ui/button/typemenu-2.png"), preload("res://assets/sprite/ui/button/typeslot-2.png")] 
var normal_texture = [preload("res://assets/sprite/ui/button/typemenu-1.png"), preload("res://assets/sprite/ui/button/typeslot-1.png")]
var previous_button = [{}, {}]

func _ready():
	#работа с перменными
	buttons_typemenu = $MarginContainer/VBoxContainer/header/VBoxContainer/buttons_typemenu
	all_grid_inv = $MarginContainer/VBoxContainer/all_grid_inv
	actionButtons = $MarginContainer/ActionButtons
	mind_bar = $MarginContainer/VBoxContainer/header/VBoxContainer/mind_bar
	pain_bar = $MarginContainer/VBoxContainer/header/VBoxContainer/pain_bar
	pain_bar_text = $MarginContainer/VBoxContainer/header/VBoxContainer2/pain_bar_text
	notes_main = $MarginContainer/VBoxContainer/notes_main
	scroll_conteiner = $MarginContainer/VBoxContainer/notes_main/HBoxContainer/ColorRect/MarginContainer/HBoxContainer/scroll_conteiner_notes
	button_back_notes = $MarginContainer/VBoxContainer/notes_main/HBoxContainer/ColorRect/MarginContainer/HBoxContainer/notes_shablon/HBoxContainer/button_back_notes
	notes_shablon = $MarginContainer/VBoxContainer/notes_main/HBoxContainer/ColorRect/MarginContainer/HBoxContainer/notes_shablon
	#вызов функций при старте
	hide_menu_inv()
	
	#подключение сигналов
	Events.connect("open_inventory", open_button)
	button_back_notes.gui_input.connect(button_back_notes_action)
	
	for i in get_tree().get_nodes_in_group("typemenu"):
		i.pressed.connect(typemenu_button_action.bind(i))

	for i in get_tree().get_nodes_in_group("ItemsSlot"):
		i.gui_input.connect(ItemsSlot.bind(i))
		
	for i in get_tree().get_nodes_in_group("button_action_item"):
		i.pressed.connect(action_items.bind(i))
	
	for i in get_tree().get_nodes_in_group("notes_button"):
		i.gui_input.connect(note_button.bind(i))

#функция возвращающая с подробного описания записи до списка записей
func button_back_notes_action(event):
	if event is InputEventMouseButton:
		if event.is_action_pressed("left_mouse"):
			notes_shablon.visible = false
			scroll_conteiner.visible = true
	pass

#функция отвечающая за нажатия на кнопки записей
func note_button(event, name):
	if event is InputEventMouseButton:
		if event.is_action_pressed("left_mouse"):
			scroll_conteiner.visible = false
			notes_shablon.visible = true

#функция отвечающая за нажатия клавиш для действий на предметы
func action_items(name):
	var index = 0
	for i in get_tree().get_nodes_in_group("ItemsSlot"):
		if i == active_itemslot:
			break
		index += 1
	var real_name = str(name).split(":")
	if real_name[0] == "eqip_button":
		print("экипировано")
	elif real_name[0] == "drop_button":
		Inventory.remove_item(index)
	actionButtons.visible = false
	$MarginContainer/VBoxContainer.modulate.a = 1
	generateItemsGrid()
	pass

#действие на нажите на ItemsSlot
func ItemsSlot(event, name):
	active_itemslot = name
	if event is InputEventMouseButton:
		if event.is_action_pressed("right_mouse"):
			if name.get_child(0).texture != null:
				$MarginContainer/VBoxContainer.modulate.a = 0.5
				actionButtons.visible = true
		if event.is_action_released("left_mouse"):
			var index = 0
			for i in get_tree().get_nodes_in_group("ItemsSlot"):
				if i == active_itemslot:
					break
				index += 1
			Inventory.remove_item(index)
			generateItemsGrid()
	pass

#действие на нажатие верхних кнопок
func typemenu_button_action(name):
	var names = str(name).split(":")
	if names[0] == "typemenu_inv":
		notes_main.visible = false
		all_grid_inv.visible = true
		notes_shablon.visible = false
		scroll_conteiner.visible = true
	elif names[0] == "typemenu_notes":
		all_grid_inv.visible = false
		notes_main.visible = true
	previous_button[0] = name
	clear_texture()
	draw_prev()

#фукнция снятия выделения со всех кнопок
func clear_texture():
	for i in get_tree().get_nodes_in_group("typemenu"):
		i.texture_normal = normal_texture[0]
	for i in get_tree().get_nodes_in_group("typeslot"):
		i.texture_normal = normal_texture[1]

#функция отрисовки выделения нажатых кнопок
func draw_prev():
	previous_button[0].texture_normal = focus_texture[0]
	previous_button[1].texture_normal = focus_texture[1]

#функция закрытия инвентаря
func hide_menu_inv():
	buttons_typemenu.visible = false
	all_grid_inv.visible = false
	pain_bar.visible = true
	pain_bar_text.visible = true

#функция открытия инвентаря
func show_menu_inv():
	buttons_typemenu.visible = true
	all_grid_inv.visible = true
	pain_bar.visible = false
	pain_bar_text.visible = false
	notes_main.visible = false

#функция подгрузки данных из глобального скрипта Inventory и изменение ItemSlot под это
func generateItemsGrid():
	var index = 0
	for i in get_tree().get_nodes_in_group("ItemsSlot"):
		if Inventory.items[index] != {}:
			i.get_child(0).texture = load("res://assets/sprite/items/" + Inventory.items[index]["icon"])
			if Inventory.items[index]["stackable"] != false:
				i.get_child(2).text = str(Inventory.items[index]["count"])
			else:
				i.get_child(2).text = ""
		else:
			i.get_child(0).texture = null
			i.get_child(2).text = ""
		index += 1
	pass

#функция открытия инвентаря по кнопке
func open_button():
	if buttons_typemenu.visible == true && all_grid_inv.visible == true:
		clear_texture()
		hide_menu_inv()
		previous_button[0] = {}
		previous_button[1] = {}
	else:
		show_menu_inv()
		$MarginContainer/VBoxContainer/header/VBoxContainer/buttons_typemenu/typemenu_inv.texture_normal = focus_texture[0]
		previous_button[0] = $MarginContainer/VBoxContainer/header/VBoxContainer/buttons_typemenu/typemenu_inv
		generateItemsGrid()
		
