extends Node

var items = []
var notes = []
var limbs = []
var abilities = []
var items_loot = []

var last_volume_sound = [-3,-3]

var learn = 1

var work_item = true
const inteval = 0.4
var dialog = false
var cutscene = false
var menu = false
func _ready():
	var temp
	
	items = read_from_json("res://assets/json-data/items.json")
	for key in items:
		items[key]["key"] = key
	
	temp = read_from_json("res://assets/json-data/notes.json")
	for key in temp:
		temp[key]["key"] = key
		notes.append(temp[key])
	
	#добавлены для проверки работоспособности, потом надо убрать
	Inventory.add_note(notes[0])
	
	temp = str("res://assets/settings/volume.txt")
	var file = File.new()
	file.open(temp, File.READ)
	temp = file.get_as_text()
	file.close()
	temp = temp.split("_")
	last_volume_sound[0] = float(temp[0])
	last_volume_sound[1] = float(temp[1])
	print(last_volume_sound)
	#limbs = read_from_json("res://assets/json-data/limbs.json")
	#for key in limbs:
	#	limbs[key]["key"] = key
	
	Events.connect("save_volume", self ,"save_volume")
	filter_data_items()

func save_volume(value_0 = last_volume_sound[0], value_1 = last_volume_sound[1]):
	last_volume_sound[0] = value_0
	last_volume_sound[1] = value_1
	var temp = str(value_0) + "_" + str(value_1)
	var saver = File.new()
	saver.open("res://assets/settings/volume.txt", File.WRITE)
	saver.store_string(temp)
	saver.close()
	pass

func read_from_json(path):
	var file = File.new()
	file.open(path,File.READ)
	var data = parse_json(file.get_as_text())
	file.close()
	return data
	
func filter_data_items():
	for i in items:
		if items[i]["loot"] == true:
			items_loot.append(i)
	pass

func items_loot_get_size():
	return items_loot.size()
