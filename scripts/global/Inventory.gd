extends Node

#перменныые отвечающие за имение у игрока вещей, записок, конечностей
var items = []
var notes = []
var limbs = []
var pain_mind = [0, 100]

#переменные под регуляцию ограничений геймплея взависимости от потерянных конечностей

#0 - нормальное использование, 1 - невозможность использовать
var use_inventory = 0

#0 - нормальное движение, 1 - немного замедленное, 2 - очень медленное
var move = 0

#под инвентарь
var size_items = 9

#функция под повреждение конечностей
func hurt_limb(limb_name, damage):
	limbs[limb_name]["damage"] += damage
	if limbs[limb_name]["damage"] > 99:
		limbs[limb_name]["lost"] = true
		match limbs[limb_name]["category"]:
			"arms":
				if limbs["left_arm"]["lost"] == true && limbs["right_arm"]["lost"] == true:
					use_inventory = 1 
			"legs":
				var temp = 0
				if limbs["left_leg"]["lost"] == true:
					temp += 1
				if limbs["right_leg"]["lost"] == true:
					temp += 1
				if temp == 1:
					move = 1
				elif temp == 2:
					move = 2
				update_hero_parametrs("move", move)
			"eyes":
				if limbs["left_eye"]["lost"] == true && limbs["right_eye"]["lost"] == true:
					use_inventory = 1
	pass

#функция которая заставляет обновлять худ при обновление конечностей
func update_hero_parametrs(category, value):
	Events.emit_signal("update_hero_parametrs", category, value)
	pass

#функция лечения конечностей
func heal_limb(limb_name, damage):
	limbs[limb_name]["damage"] += damage
	if limbs[limb_name]["damage"] < 100:
		limbs[limb_name]["lost"] = false
		match limbs[limb_name]["category"]:
			"arms":
				if limbs["left_arm"]["lost"] == false || limbs["right_arm"]["lost"] == false:
					use_inventory = 0 
			"legs":
				var temp = 0
				if limbs["left_leg"]["lost"] == false:
					temp += 1
				if limbs["right_leg"]["lost"] == false:
					temp += 1
				if temp == 1:
					move = 1
				elif temp == 2:
					move = 0
				update_hero_parametrs("move", move)
			#"eyes":
				#if limb["left_eye"]["lost"] == false && limb["right_eye"]["lost"] == false:
				#	use_inventory = 1 
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

#функция для обновления нужных нод при изменении каких-то вещей связанных с персонажем
func update(index):
	Events.emit_signal("update_hero", index)
	pass
