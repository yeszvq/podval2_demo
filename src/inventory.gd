extends Node


var items = []

func _ready():
	for i in 8:
		items.append({})

func set_item(item, index):
	items.insert(index, item)
	pass
	
func remove_item(index):
	items.remove_at(index)
	pass
	
func set_item_count(item, count):
	pass
