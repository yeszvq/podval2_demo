extends Node

var items
var notes = []
var abilities = []

#Вызов функции чтения, а также генерация списка предметов
func _ready():
	var temp
	items = read_from_json("res://assets/json data/items.json")
	for key in items:
		items[key]["key"] = key

	temp = read_from_json("res://assets/json data/notes.json")
	for key in temp:
		temp[key]["key"] = key
		notes.append(temp[key])
	
	temp = read_from_json("res://assets/json data/abilities.json")
	for key in temp:
		temp[key]["key"] = key
		abilities.append(temp[key])
	
	temp = read_from_json("res://assets/json data/limbs.json")
	for key in temp:
		temp[key]["key"] = key
		Inventory.limbs.append(temp[key])
#Чтение данных из файла
func read_from_json(path):
	var file = FileAccess.open(path, FileAccess.READ)
	var data_file = JSON.parse_string(file.get_as_text())
	return data_file
