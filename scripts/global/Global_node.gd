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
	Events.connect("start_music", self, "start_music")
	Events.connect("stop_music", self, "stop_music")
	Events.connect("start_sound", self, "start_sound")
	Events.connect("stop_sound", self, "stop_sound")
	Global.work_item = true
	pass # Replace with function body.

func stop_sound():
	$Sounds_player.stop()
	pass
	
func start_sound(name, loop = false):
	print("work")
	$Sounds_player.stop()
	$Sounds_player.stream = load("res://assets/sounds/" + name +".wav")
	$Sounds_player.play()
	pass

func stop_music():
	$AudioStreamPlayer.stop()
	pass
	
func start_music(name, loop = false):
	$AudioStreamPlayer.stop()
	$AudioStreamPlayer.stream = load("res://assets/sounds/" + name +".ogg")
	$AudioStreamPlayer.play()
	pass

func start_game():
	#start_music("music_game")
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
