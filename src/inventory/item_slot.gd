extends ColorRect

@export var index = 0

var item_icon
var item_count
var block = false

func _ready():
	item_icon = $TextureRect
	item_count = $Label
	Events.connect("open_inventory_generate_itemslot", open_inventory_generate_itemslot)
	Events.connect("open_inventory_hide_border", open_inventory_hide_border)
	Events.connect("open_inventory_button", open_inventory_button)
	$PanelContainer.visible = false

#Выбор ItemSlot и блокировка нажатий на них
func _on_gui_input(event):
	if block == false:
		if Input.is_action_just_released("right_mouse"):
			$PanelContainer.visible = true
			Events.emit_signal("open_inventory_button", index)
	pass

#Убираем рамку и разрешаем снова выделять ItemSlot
func open_inventory_hide_border():
	$PanelContainer.visible = false
	block = false


#тут подргружаем данные для ItemSlot
func open_inventory_generate_itemslot():
	if Inventory.items[index] != {}:
		item_icon.texture = load("res://assets/sprite/items/" + Inventory.items[index]["icon"])
		if Inventory.items[index]["stackable"] == true:
			item_count.text = str(Inventory.items[index]["count"])
		else:
			item_count.text = ""
	else:
		item_icon.texture = null
		item_count.text = ""
	pass

#Так как кнопки убрались, то разрешаем уже выбирать другие
func open_inventory_button(index):
	block = true
