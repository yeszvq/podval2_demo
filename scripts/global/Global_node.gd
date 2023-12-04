extends Node2D

func _ready():
	print("запустилось")
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

func drop_item(index):
	var object = load("res://scene/object/pick_up_item/item_" + str(index) + ".tscn").instance()
	var object_position = get_child(0).get_child(0).get_node("hero").position
	get_child(0).get_child(0).add_child(object)
	object.position = Vector2(object_position.x, object_position.y + 15)
	pass
