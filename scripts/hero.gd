extends KinematicBody2D

#перменные для передвижения
var normal_speed = 50
var speed = 50
var input_direction
var previos_direction = Vector2(0,1)
var velocity = Vector2()
var dialog_open = false
var cutscene = false
var flashlight = false
var dark = false
var last_dark = false
var safepoint = false
var stop_pain_mind = false
var last_pain_mind = []
var monstr_nearby = false
var open_inventory = false

#var show_is = 0

func _ready():
	Events.connect("start_dialog_for_hero", self, "start_dialog")
	Events.connect("update_hero_parametrs", self, "update_hero_parametrs")
	Events.connect("end_dialog", self, "end_dialog")
	Events.connect("start_dialogue", self, "start_dialog")
	Events.connect("dark_off", self, "dark_off")
	Events.connect("dark_on", self, "dark_on")
	Events.connect("show_light_hero", self, "on_light")
	Events.connect("hide_light_hero", self, "off_light")
	Events.connect("no_mind", self, "no_mind")
	Events.connect("safe_point_on", self, "safe_point_on")
	Events.connect("inventorytrue", self, "inventorytrue")
	Events.connect("legs_heart", self, "legs_heart")
	Events.connect("legs_heal", self, "legs_heal")
	Events.connect("hero_anim_lig_of", self, "lig_of")
	Events.connect("hero_anim_lig_on", self, "lig_on")
	Events.connect("respawn", self, "respawn")
	Events.connect("respawn_1", self, "respawn")
#	Events.connect("show_i", self, "show_i")
#	Events.connect("hide_i", self, "hide_i")
	pass

func respawn():
	open_inventory = true
	pass

func lig_of():
	$AnimationPlayer.play("lig_of")
	pass
	
func lig_on():
	$AnimationPlayer.play("lig_on")
	pass
#func hide_i():
#	if show_is == 0 || show_is - 1 == 0:
#		$TextureRect.visible = false
#		show_is = show_is - 1
#	else:
#		show_is = show_is - 1
#	print(show_is)
#	pass

#func show_i():
#	show_is = show_is + 1
#	$TextureRect.visible = true
#	print(show_is)
#	pass

func add_item(name):
	Inventory.add_item(Global.items[name])
	pass

func pain_mind_change(index, value):
	Inventory.pain_mind_change(int(index), int(value))
	pass

func legs_heart():
	$AnimatedSprite/AnimatedSprite2.visible = true
	pass
	
func legs_heal():
	$AnimatedSprite/AnimatedSprite2.visible = false
	pass

func visible_off():
	$AnimatedSprite.visible = false
	pass
	
func visible_on():
	$AnimatedSprite.visible = true
	pass
	
func add_hear(name):
	Inventory.add_heart(name)
	pass
	
func remove_item(name):
	Inventory.remove_item(Global.items[name])
	pass
	
func inventorytrue():
	open_inventory = true
	pass

func safe_point_on():
	#last_pain_mind = Inventory.pain_mind
	#print("назначение" + str(last_pain_mind))
	safepoint = true
	Inventory.safepoint = 2
	#print("назначение_2" + str(last_pain_mind))
	pass
	
func set_position(pos):
	position = pos
	pass
	
func set_die_can():
	Inventory.die_can = true
	pass
	
func emit_signal(name):
	Events.emit_signal(name)
	pass

func emit_signal_0(name, value):
	Events.emit_signal(name, value)
	pass

func no_mind():
	if safepoint == false:
		#Inventory.safepoint = false
		Events.emit_signal("use_cutscene", "death_0")
	else:
		Events.emit_signal("use_cutscene", "death_0")
		Inventory.safepoint = 2
		Inventory.pain_mind[0] = 0
		Inventory.pain_mind[1] = 100
	pass
	
func change_spriteframes(path):
	$AnimatedSprite.frames = load(path)
	pass

	
func dark_off():
	dark = false
	last_dark = false
	pass

func dark_on():
	dark = true
	last_dark = true
	pass
	
func off_light():
	$lights.visible = false
	pass
	
func on_light():
	$lights.visible = true

func camera_current():
	$Camera2D.current = true

func start_dialog(name_path = null):
	Global.dialog = true
	dark = false
	dialog_open = true
	pass

func end_dialog():
	Global.dialog = false
	if last_dark == true:
		dark = true
	dialog_open = false
	pass

func update_hero_parametrs(category, count):
	match category:
		"move":
			if count == 0:
				speed = normal_speed
			if count == 1:
				speed = normal_speed / 2
			if count == 2:
				speed = normal_speed / 4
	pass
	
func get_input():
	var temp = Vector2()
	input_direction = Input.get_vector("left", "right", "up", "down")
	temp = input_direction
	if input_direction.x != 0 && input_direction.y != 0:
		temp = temp.sign()
		input_direction = Vector2(input_direction.x * 2, input_direction.y)
	if temp != Vector2(0,0):
		previos_direction = temp
		$AnimatedSprite.play("run_" + str(temp.x) + "_"+ str(temp.y))
		$AnimatedSprite/AnimatedSprite2.play("run_" + str(temp.x) + "_"+ str(temp.y))
		Events.emit_signal("walk_start")
	elif temp == Vector2(0,0):
		$AnimatedSprite.play("idle_" + str(previos_direction.x) + "_"+ str(previos_direction.y))
		$AnimatedSprite/AnimatedSprite2.play("idle_" + str(previos_direction.x) + "_"+ str(previos_direction.y))
		Events.emit_signal("walk_stop")
	input_direction = input_direction.normalized()
	velocity = input_direction * speed
	
func _input(event):
	if dialog_open == false && cutscene == false:
		if Input.is_action_just_released("open_notebook") && dialog_open == false && open_inventory == true:
			Events.emit_signal("open_notebook")
#		if Input.is_action_just_released("test"):
#			Inventory.pain_mind_change(0, 10)
#		#if Input.is_action_just_released("esc") && dialog_open == false && open_inventory == true:
#		#	Events.emit_signal("open_menu")
#		if Input.is_action_just_released("test"):
#			Inventory.pain_mind_change(1,-5)
	pass
	
func _process(delta):
	if cutscene == false:
		if dialog_open == false:
			get_input()
			velocity = move_and_slide(velocity)
		else:
			$AnimatedSprite.play("idle_" + str(previos_direction.x) + "_"+ str(previos_direction.y))
			$AnimatedSprite/AnimatedSprite2.play("idle_" + str(previos_direction.x) + "_"+ str(previos_direction.y))
	pass


func _on_Timer_timeout():
	if dialog_open == false && cutscene == false:
		if Inventory.pain_mind[0] != 0:
			Inventory.pain_mind_change(1, -1)
		if Inventory.pain_mind[1] != 0 && dark == true:
			Inventory.pain_mind_change(1, -1)
	pass # Replace with function body.


func _on_Timer2_timeout():
	if dialog_open == false && cutscene == false:
		if Inventory.pain_mind[0] != 0: 
			Inventory.pain_mind_change(0, -1)
	pass # Replace with function body.
	
	
#Код для запуска нужных анимаций в катсценах
func play_anim(animation_name):
	var temp = animation_name.split("_")
	previos_direction = Vector2(float(temp[1]), float(temp[2]))
	$AnimatedSprite.play(animation_name)
	$AnimatedSprite/AnimatedSprite2.play(animation_name)

func stop_anim():
	$AnimatedSprite.stop()
	
func start_cutscene():
	Events.emit_signal("walk_stop")
	$AnimatedSprite.play("idle_" + str(previos_direction.x) + "_"+ str(previos_direction.y))
	$AnimatedSprite/AnimatedSprite2.play("idle_" + str(previos_direction.x) + "_"+ str(previos_direction.y))
	Global.cutscene = true
	Events.emit_signal("notebook_hide")
	cutscene = true
	pass
	
func camera_move(pos):
	$Camera2D.position = pos
	pass
	
func stop_cutscene():
	Global.cutscene = false
	cutscene = false
	pass

func use_stop_cutscene():
	Events.emit_signal("use_stop_cutscene")
	pass

func start_dialogue(name_dialogue):
	Events.emit_signal("walk_stop")
	Global.dialog = true
	dialog_open = true
	Events.emit_signal("start_dialogue", name_dialogue)
