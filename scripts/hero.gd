extends KinematicBody2D

#перменные для передвижения
var normal_speed = 50
var speed = 50
var input_direction
var previos_direction = Vector2(0,1)
var velocity = Vector2()
var dialog_open = false

var flashlight = false

var monstr_nearby = false

func _ready():
	Events.connect("update_hero_parametrs", self, "update_hero_parametrs")
	Events.connect("end_dialog", self, "end_dialog")
	Events.connect("start_dialogue", self, "start_dialog")
	pass
	
func start_dialog(name_path):
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
	if dialog_open == false:
		if Input.is_action_just_released("open_notebook") && dialog_open == false:
			Events.emit_signal("open_notebook")
	pass
	
func _process(delta):
	if dialog_open == false:
		get_input()
		velocity = move_and_slide(velocity)
	else:
		$AnimatedSprite.play("idle_" + str(previos_direction.x) + "_"+ str(previos_direction.y))
	pass


func _on_Timer_timeout():
	if flashlight == false:
		Inventory.pain_mind_change(1, -1)
	if monstr_nearby == true:
		Inventory.pain_mind_change(1, -1)
	if Inventory.pain_mind[0] != 0:
		Inventory.pain_mind_change(1, -1)
	pass # Replace with function body.


func _on_Timer2_timeout():
	if Inventory.pain_mind[0] != 0:
		Inventory.pain_mind_change(0, -1)
	pass # Replace with function body.
