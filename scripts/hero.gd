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

var monstr_nearby = false

func _ready():
	Events.connect("start_dialog_for_hero", self, "start_dialog")
	Events.connect("update_hero_parametrs", self, "update_hero_parametrs")
	Events.connect("end_dialog", self, "end_dialog")
	Events.connect("start_dialogue", self, "start_dialog")
	Events.connect("dark_off", self, "dark_off")
	Events.connect("dark_on", self, "dark_on")
	Events.connect("show_light_hero", self, "on_light")
	Events.connect("hide_light_hero", self, "off_light")
	pass
	
func dark_off():
	dark = false
	pass

func dark_on():
	dark = true
	pass
	
func off_light():
	$lights.visible = false
	pass
	
func on_light():
	$lights.visible = true

func camera_current():
	$Camera2D.current = true	

func start_dialog(name_path = null):
	dialog_open = true
	pass

func end_dialog():
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
	elif temp == Vector2(0,0):
		$AnimatedSprite.play("idle_" + str(previos_direction.x) + "_"+ str(previos_direction.y))
	input_direction = input_direction.normalized()
	velocity = input_direction * speed
	
func _input(event):
	if dialog_open == false && cutscene == false:
		if Input.is_action_just_released("open_notebook") && dialog_open == false:
			Events.emit_signal("open_notebook")
		if Input.is_action_just_released("test"):
			Events.emit_signal("call_test_panel")
	pass
	
func _process(delta):
	if cutscene == false:
		if dialog_open == false:
			get_input()
			velocity = move_and_slide(velocity)
		else:
			$AnimatedSprite.play("idle_" + str(previos_direction.x) + "_"+ str(previos_direction.y))
	pass


func _on_Timer_timeout():
	if Inventory.pain_mind[0] != 0:
		Inventory.pain_mind_change(1, -1)
	if Inventory.pain_mind[1] != 0 && dark == true:
		Inventory.pain_mind_change(1, -1)
	pass # Replace with function body.


func _on_Timer2_timeout():
	if Inventory.pain_mind[0] != 0: 
		Inventory.pain_mind_change(0, -1)
	pass # Replace with function body.
	
	
#Код для запуска нужных анимаций в катсценах
func play_anim(animation_name):
	var temp = animation_name.split("_")
	previos_direction = Vector2(float(temp[1]), float(temp[2]))
	$AnimatedSprite.play(animation_name)

func stop_anim():
	$AnimatedSprite.stop()
	
func start_cutscene():
	cutscene = true
	pass
	
func camera_move(pos):
	$Camera2D.position = pos
	pass
	
func stop_cutscene():
	cutscene = false
	pass

func use_stop_cutscene():
	Events.emit_signal("use_stop_cutscene")
	pass

func start_dialogue(name_dialogue):
	dialog_open = true
	Events.emit_signal("start_dialogue", name_dialogue)
