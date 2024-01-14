extends Node2D

var blood_point = preload("res://scene/object/blood_point.tscn")
var blood_can = true

func _ready():
	
	$YSort/item_2/AudioStreamPlayer.volume_db = Global.last_volume_sound[1]
	$YSort/item_2/AudioStreamPlayer2.volume_db = Global.last_volume_sound[1]
	$YSort/item_2/AudioStreamPlayer3.volume_db = Global.last_volume_sound[1]
	$YSort/item_2/AudioStreamPlayer2D.volume_db = Global.last_volume_sound[1]
	$YSort/item_2/AudioStreamPlayer2D2.volume_db = Global.last_volume_sound[1]
	
	$YSort/item_2/AudioStreamPlayer2D2.playing = true
	
	Events.connect("show_light", self, "show_light")
	Events.connect("hide_light", self, "hide_light")
	Events.connect("open_menu", self, "pause")
	Events.connect("changed_sound_value", self, "changed_sound_value")
	Events.connect("create_blood", self, "create_blood")
	#Events.connect("hide_menu", self, "unpause")
	match Inventory.safepoint:
		0:
			#Стандарт
			$AnimationPlayer.play("start")
			#print()
		1:
			#Камера
			$AnimationPlayer/Camera2D.current = false
			$YSort/hero/Camera2D.current = true
			$YSort/hero/AnimatedSprite.frames = load("res://assets/resourse/hero.tres")
			$YSort/hero.position = Vector2(175, 36)
			$YSort/ne_gosha_1.visible = false
			$YSort/ne_gosha_2.visible = false
			$YSort/ne_gosha_3.visible = false
			Events.emit_signal("zaval")
		2:
			#Лабиринт
			Events.emit_signal("respawn_1")
			$AnimationPlayer/Camera2D.current = false
			$YSort/hero/Camera2D.current = true
			$YSort/hero.position = Vector2(1745, -351)
			$YSort/hero/AnimatedSprite.frames = load("res://assets/resourse/hero_no_arm_frames.tres")
		3:
			#Зал
			$AnimationPlayer/Camera2D.current = false
			$YSort/hero/Camera2D.current = true
			$YSort/hero.position = Vector2(1271, 135)
			Events.emit_signal("map_new_list", "map_demo_3")
			$YSort/hero/AnimatedSprite.frames = load("res://assets/resourse/hero.tres")
			$YSort/ne_gosha_1.visible = false
			$YSort/ne_gosha_2.visible = false
			$YSort/ne_gosha_3.visible = false
			Events.emit_signal("zaval")
			Events.emit_signal("respawn")
			if Inventory.memory[1] == true && Inventory.memory[2] == false:
				Inventory.add_item("deadRat")
			elif Inventory.memory[1] == true && Inventory.memory[2] == true:
				Inventory.add_item("goodRat")
	pass

func create_blood():
	if blood_can == true && Global.dialog == false && Global.cutscene == false:
		blood_can = false
		print("blood_create")
		$Timer.start()
		var temp = blood_point.instance()
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		$Timer.start(rng.randf_range(0.4, 0.8))
		temp.texture = load("res://assets/sprites/object/blood_run/" + str(rng.randi_range(0, 3)) + ".png")
		temp.position = Vector2($YSort/hero.position.x, $YSort/hero.position.y + 18)
		$YSort.add_child(temp)
	pass

func changed_sound_value(value):
	$YSort/item_2/AudioStreamPlayer.volume_db = Global.last_volume_sound[1]
	$YSort/item_2/AudioStreamPlayer2.volume_db = Global.last_volume_sound[1]
	$YSort/item_2/AudioStreamPlayer3.volume_db = Global.last_volume_sound[1]
	$YSort/item_2/AudioStreamPlayer2D.volume_db = Global.last_volume_sound[1]
	
func pause():
	get_tree().paused = true
	pass # Replace with function body.
	
#func unpause():
	#get_tree().paused = false
	#pass

func show_light():
	$CanvasModulate.visible = true
	$YSort/hero/Light2D2.visible = true
	$YSort/hero/Light2D.visible = true
	
	pass

func hide_light():
	$CanvasModulate.visible = false
	$YSort/hero/Light2D2.visible = false
	$YSort/hero/Light2D.visible = false
	pass


func _on_Timer_timeout():
	blood_can = true
	pass # Replace with function body.
