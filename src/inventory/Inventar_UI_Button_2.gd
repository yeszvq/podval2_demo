extends HBoxContainer

var index_ItemSlot

func _ready():
	visible = false
	Events.connect("open_inventory_hide_button",open_inventory_hide_button)
	Events.connect("open_inventory_button", open_inventory_button)
	$Button.connect("button_up",  button_action)

#Кнопка, которая отменяет выделение ячейки и скрывает кнопки.
func button_action():
	visible = false
	Events.emit_signal("open_inventory_hide_button")
	Events.emit_signal("open_inventory_hide_border")

#Открывает в целом это кнопку
func open_inventory_button(index):
	visible = true

#Скрывает кнопку, если одна из кнопок появляющихся инвентаря нажата
func open_inventory_hide_button():
	visible = false
