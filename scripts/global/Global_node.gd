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
	
	var object_position = get_child(0).get_child(0).get_node("hero").position
	get_child(0).get_child(0).add_child(object)
	object.position = Vector2(object_position.x, object_position.y + 10)
	pass
