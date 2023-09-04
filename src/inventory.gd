extends Node


var items = []
var lenght = 9

#Заранее генерим 9 пустых ячеек
func _ready():
	for i in lenght:
		items.append({})

#Добавляем предмет
func set_item(item):
	if items.has({}):
		if item["stackable"] == true && items.has(item):
			item["count"] += 1
		else:
			for i in lenght:
				if items[i] == {}:
					items[i] = item
					break
	else:
		return false
	update()
	pass

#Удаляем предмет
func remove_item(index):
	items[index] = {}
	update()
	pass

#Увеличиваем количество
func remove_item_count(index, count):
	if items[index]["count"] - count == 0 || items[index]["count"] - count < 0:
		items[index] = {}
	else:
		items[index]["count"] -= count
	update()
	pass

#сигнал, чтобы если предмет появился во время открытого инвентаря, то он бы сразу показался
func update():
	pass
