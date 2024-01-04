extends Node

#перменныые отвечающие за имение у игрока вещей, записок, конечностей
var items = []
var notes = []
var limbs_heart = []
var pain_mind = [0, 100]

#переменные под регуляцию ограничений геймплея взависимости от потерянных конечностей

#0 - нормальное использование, 1 - невозможность использовать
var use_inventory = 0

#0 - нормальное движение, 1 - немного замедленное, 2 - очень медленное
var move = 0

#под смерть
var die_can = true

#под инвентарь
var size_items = 9

#Эффекты на игроке
var does_effect = []

#функция под повреждение конечностей

#функция которая заставляет обновлять худ при обновление конечностей
func update_hero_parametrs(category, value):
	Events.emit_signal("update_hero_parametrs", category, value)
	pass

#функция лечения конечностей
func add_heart(name):
	if limbs_heart.find(name) == -1:
		limbs_heart.append(name)
		update(2)
		if name == "legs":
			Events.emit_signal("legs_heart")
	pass


#функция добавления предмета
func add_item(item):
	if items.size() < size_items:
		items.append(item)
		update(1)
		return true
	else:
		return false

#функция изменяющая боль и разум
func pain_mind_change(index, count):
	if (pain_mind[index] + count) >= 100:
		pain_mind[index] = 100
	elif (pain_mind[index] + count) <= 0:
		pain_mind[index] = 0
	else:
		pain_mind[index] += count

	if limbs_heart.find("legs") != -1 && pain_mind[0] <= 5:
		#print(limbs_heart)
		limbs_heart.remove(limbs_heart.find("legs"))
		Events.emit_signal("legs_heal")
		#print(limbs_heart)
		#update(2)
	
	if pain_mind[1] <= 50:
		Events.emit_signal("low_mind", pain_mind[1])
	else:
		Events.emit_signal("more_mind")
	
	if pain_mind[0] >= 20:
		Events.emit_signal("low_pain", pain_mind[0])
	else:
		Events.emit_signal("more_pain")
	
	if pain_mind[1] <= 0 && die_can:
		Events.emit_signal("no_mind")
	update(2)

#функция дающая число предметов в инвентаре
func count_inv():
	return items.size()

#функция удаления предмета по названию
func remove_item(item):
	items.remove(items.find(item))
	update(1)

#функция удаления предмета по индексу
func remove_item_index(index):
	items.remove(index)
	update(1)
	
#функция возвращающая предмет по индексу
func find_item_index(index):
	return items[index]

func find_item_name(name):
	return items.find(Global.items[name])

#функция добавления записок
func add_note(note):
	if notes.find(note) == -1:
		notes.append(note)
	update(0)
	pass

func get_body():
	if limbs_heart.find("legs") != -1 && limbs_heart.find("arm") != -1:
		return "legs_arm"
	elif limbs_heart.find("legs") != -1 && limbs_heart.find("arm") == -1:
		return "legs"
	elif limbs_heart.find("legs") == -1 && limbs_heart.find("arm") != -1:
		return "arm"
	elif limbs_heart.find("legs") == -1 && limbs_heart.find("arm") == -1:
		return "none"
	pass

#функция для обновления нужных нод при изменении каких-то вещей связанных с персонажем
func update(index):
	Events.emit_signal("update_hero", index)
	pass
