extends Node

var items = []
var notes = []
var limbs = []
var pain_mind = [0, 100]

var size_items = 9

#функция добавления предмета
func add_item(item):
	if items.size() < size_items:
		items.append(item)
		return true
	else:
		return false
	update(1)

#функция изменяющая боль и разум
func pain_mind_change(index, count):
	#print("work")
	if index == 1 && pain_mind[1] > 0:
		pain_mind[index] += count
	update(2)
#функция дающая число предметов в инвентаре
func count_inv():
	return items.size()

#функция удаления предмета
func remove_item(item):
	items.remove(items.find(item))
	update(1)

#функция добавления записок
func add_note(note):
	if notes.find(note) == -1:
		notes.append(note)
	update(0)
	pass

#функция для обновления нужных нод при изменении каких-то вещей связанных с персонажем
func update(index):
	Events.emit_signal("update_hero", index)
	pass
