extends Node

#1 - pain 0-maind
var mind_pain = [0, 0]
var notes = []
var items = []
var lenght = 9
var limbs = []

#Заранее генерим 9 пустых ячеек
func _ready():
	for i in lenght:
		items.append({})
	set_item(Global.items["sword"])
	set_item(Global.items["apple"])
	set_item(Global.items["armor"])
	set_item(Global.items["potion"])
	notes.append(Global.notes[0])
	notes.append(Global.notes[1])
	notes.append(Global.notes[2])
	notes.append(Global.notes[3])
	#print(items[0])

#изменяем состояние конечности
func limb_change(index, damage):
	limbs[index]["damage"] = damage
	update(3, true)
	pass

#изменяем значение состойний
func bar_change(index, value):
	mind_pain[index] += value
	update(2)

#количество вещей в инвентаре
func count_inv():
	var count = 0
	for i in items:
		if i != {}:
			count += 1
	return count

#Добавляем записку
func add_note(note):
	notes.append(note)
	update(0)

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
	update(1)
	pass

#Удаляем предмет
func remove_item(index):
	items[index] = {}
	update(1)
	pass

#Увеличиваем количество
func remove_item_count(index, count):
	if items[index]["count"] - count == 0 || items[index]["count"] - count < 0:
		items[index] = {}
	else:
		items[index]["count"] -= count
	update(1)
	pass

#сигнал, чтобы если предмет появился во время открытого инвентаря, то он бы сразу показался
func update(index, limb = false):
	Events.emit_signal("update_notebook", index, limb)
	pass
