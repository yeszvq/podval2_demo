extends Node

var items = []
var notes = []
var limbs = []
var abilities = []

func _ready():
	var temp
	
	items = read_from_json("res://assets/json-data/items.json")
	for key in items:
		items[key]["key"] = key
	
	#добавлены для проверки работоспособности, потом надо убрать
	Inventory.add_item(items["sword"])
	Inventory.add_item(items["apple"])
	
	temp = read_from_json("res://assets/json-data/notes.json")
	for key in temp:
		temp[key]["key"] = key
		notes.append(temp[key])
	
	#добавлены для проверки работоспособности, потом надо убрать
	Inventory.notes.append(notes[0])
	Inventory.notes.append(notes[1])
	Inventory.notes.append(notes[2])
	
	limbs = read_from_json("res://assets/json-data/limbs.json")
	for key in limbs:
		limbs[key]["key"] = key
	
	Inventory.limbs = limbs

func read_from_json(path):
	var file = File.new()
	file.open(path,File.READ)
	var data = parse_json(file.get_as_text())
	file.close()
	return data
