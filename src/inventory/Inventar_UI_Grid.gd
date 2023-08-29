extends GridContainer



func _ready():
	visible = false
	Events.connect("open_inventory", open_inventory)

#Появление таблицы инветаря, а также сигнал на генерацию данных у ItemSlot
func open_inventory():
	if visible == false:
		Events.emit_signal("open_inventory_generate_itemslot")
		visible = true
	else:
		visible = false
