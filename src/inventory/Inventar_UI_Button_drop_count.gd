extends HBoxContainer

var index_ItemSlot

func _ready():
	visible = false
	Events.connect("open_inventory_hide_button",open_inventory_hide_button)
	Events.connect("open_inventory_button", open_inventory_button)
	$Button.connect("button_up",  button_action)
	Events.connect("hide_slider_inv", hide_slider_inv)
	Events.connect("open_inventory_move_index_itemslot", open_inventory_move_index_itemslot)

func hide_slider_inv():
	visible = true
#Кнопка, которая вызывает поле для ввода числа

func button_action():
	if Inventory.items[index_ItemSlot] != {}:
		if Inventory.items[index_ItemSlot]["stackable"] != false:
			visible = false
			Events.emit_signal("open_inventory_show_change_count_slider")

#Открывает в целом это кнопку
func open_inventory_button(index):
	visible = true

#Скрывает кнопку, если одна из кнопок появляющихся инвентаря нажата
func open_inventory_hide_button():
	visible = false
	
func open_inventory_move_index_itemslot(index):
	index_ItemSlot = index
