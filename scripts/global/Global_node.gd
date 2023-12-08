extends Node2D

var item_0 = preload("res://scene/object/pick_up_item/item_0.tscn")
var item_1 = preload("res://scene/object/pick_up_item/item_1.tscn")
var item_2 = preload("res://scene/object/pick_up_item/item_2.tscn")
var item_3 = preload("res://scene/object/pick_up_item/item_3.tscn")

func _ready():
	$level_one/AnimationPlayer.play("start")
	#print("запустилось")
	Events.connect("handle_click_storage", self, "handle_click_storage")
	Events.connect("drop_item", self, "drop_item")
	Global.work_storage = true
	pass # Replace with function body.

func handle_click_storage():
	Global.work_storage = false
	$Timer.start()
	pass

func _on_Timer_timeout():
	Global.work_storage = true
	pass # Replace with function body.

func drop_item(item):
	var object
	var index_item = str(item["index"])
	match index_item:
		"0":
			object = item_0.instance()
		"1":
			object = item_1.instance()
		"2":
			object = item_2.instance()
		"3":
			object = item_3.instance()
	
	var object_position = get_child(0).get_child(0).get_node("hero").position
	get_child(0).get_child(0).add_child(object)
	object.position = Vector2(object_position.x, object_position.y + 10)
	pass
