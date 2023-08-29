extends Node

var items

#Вызов функции чтения, а также генерация списка предметов
func _ready():
	items = read_from_json("res://assets/json data/items.json")
	for key in items:
		items[key]["key"] = key
	
#Чтение данных из файла
func read_from_json(path):
	var file = FileAccess.open(path, FileAccess.READ)
	var data_file = JSON.parse_string(file.get_as_text())
	return data_file
