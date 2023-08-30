extends HBoxContainer

var index_itemslot

func _ready():
	visible = false
	Events.connect("open_inventory_button", open_inventory_button)
	Events.connect("open_inventory_hide_button", open_inventory_hide_button)
	Events.connect("open_inventory_show_change_count_slider", open_inventory_hide_button)
	$Button.connect("button_up", button_one_action)
	$Button2.connect("button_up", button_two_action)
	Events.connect("hide_slider_inv", hide_slider_inv)

func hide_slider_inv():
	visible = true

#Первая кнопка и сигнал на разрешение выделения других ItemSlot и скрытие всех кнопок
func button_one_action():
	print("предмет использован")
	Events.emit_signal("open_inventory_hide_border")
	Events.emit_signal("open_inventory_hide_button")
	visible = false

#Вторая кнопка и сигнал на разрешение выделения других ItemSlot и скрытие всех кнопок
func button_two_action():
	visible = false
	Events.emit_signal("open_inventory_hide_border")
	Events.emit_signal("open_inventory_hide_button")
	Inventory.remove_item(index_itemslot)
	print("предмет выброшен")

#Просто делаем доступными эти кнопки
func open_inventory_button(index):
	index_itemslot = index
	Events.emit_signal("open_inventory_move_index_itemslot", index)
	visible  = true

#Скрывает кнопку, если одна из кнопок появляющихся инвентаря нажата	
func open_inventory_hide_button():
	visible = false
	Events.emit_signal("open_inventory_hide_border")
	pass

