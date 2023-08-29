extends Node


var items = []

#Заранее генерим 9 пустых ячеек
func _ready():
	for i in 9:
		items.append({})

#Добавляем предмет
func set_item(item, index):
	items[index] = item
	update()
	pass

#Удаляем предмет
func remove_item(index):
	items[index] = {}
	update()
	pass

#Увеличиваем количество
func set_item_count(item, count):
	update()
	pass

#сигнал, чтобы если предмет появился во время открытого инвентаря, то он бы сразу показался
func update():
	Events.emit_signal("open_inventory_generate_itemslot")
