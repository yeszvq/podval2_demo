extends Node2D

var level_one = preload("res://scene/level/level_one.tscn")
var titri = preload("res://scene/object/titri.tscn")
var main_menu = preload("res://scene/object/main_menu.tscn")

func _ready():
	#$level_one/AnimationPlayer.play("start")
	#print("запустилось")
	Events.connect("handle_click_storage", self, "handle_click_storage")
	Events.connect("use_cutscene", self, "play_cutscene")
	Events.connect("usecutscene", self, "play_cutscene")
	Events.connect("start_game", self, "start_game")
	Events.connect("back_menu", self, "back_menu")
	Events.connect("end_game", self, "end_game")
	Global.work_item = true
	pass # Replace with function body.


func start_game():
	Inventory.pain_mind[0] = 0
	Inventory.pain_mind[1] = 100
	$Node2D.queue_free()
	add_child(level_one.instance())
	#$level_one/AnimationPlayer.play("start")
	Global.work_item = true
	pass

func end_game():
	$level_one.queue_free()
	add_child(titri.instance())
	pass
	
func back_menu():
	$titri.queue_free()
	add_child(main_menu.instance())
	pass

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
