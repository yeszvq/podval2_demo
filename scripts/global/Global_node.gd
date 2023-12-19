extends Node2D

var item_0 = preload("res://scene/object/pick_up_item/item_0.tscn")
var item_1 = preload("res://scene/object/pick_up_item/item_1.tscn")
var item_2 = preload("res://scene/object/pick_up_item/item_2.tscn")
var item_3 = preload("res://scene/object/pick_up_item/item_3.tscn")
var item_4 = preload("res://scene/object/pick_up_item/item_4.tscn")
var item_5 = preload("res://scene/object/pick_up_item/item_5.tscn")
var item_6 = preload("res://scene/object/pick_up_item/item_6.tscn")
var item_7 = preload("res://scene/object/pick_up_item/item_7.tscn")
var item_8 = preload("res://scene/object/pick_up_item/item_8.tscn")
var item_9 = preload("res://scene/object/pick_up_item/item_9.tscn")
var item_10 = preload("res://scene/object/pick_up_item/item_10.tscn")
var item_11 = preload("res://scene/object/pick_up_item/item_11.tscn")

func _ready():
	#$level_one/AnimationPlayer.play("start")
	#print("запустилось")
	Events.connect("handle_click_storage", self, "handle_click_storage")
	Events.connect("drop_item", self, "drop_item")
	Events.connect("use_cutscene", self, "play_cutscene")
	Global.work_item = true
	pass # Replace with function body.


func play_cutscene(name):
	$level_one/AnimationPlayer.play(name)
	pass

func handle_click_storage():
	Global.work_item = false
	$Timer.start()
	pass

func _on_Timer_timeout():
	Global.work_item = true
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
		"4":
			object = item_4.instance()
		"5":
			object = item_5.instance()
		"6":
			object = item_6.instance()
		"7":
			object = item_7.instance()
		"8":
			object = item_8.instance()
		"9":
			object = item_9.instance()
		"10":
			object = item_10.instance()
		"11":
			object = item_11.instance()
			
	var object_position = get_child(0).get_child(0).get_node("hero").position
	get_child(0).get_child(0).add_child(object)
	object.position = Vector2(object_position.x, object_position.y + 10)
	pass
