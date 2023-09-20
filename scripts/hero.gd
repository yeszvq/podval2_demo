extends KinematicBody2D

#перменные для передвижения
var speed = 50
var input_direction
var previos_direction = Vector2(0,1)
var velocity = Vector2()

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
	if Input.is_action_just_released("open_notebook"):
		Events.emit_signal("open_notebook")
	pass
	
func _process(delta):
	get_input()
	velocity = move_and_slide(velocity)
	pass


func _on_Timer_timeout():
	Inventory.pain_mind_change(1, -1)
	pass # Replace with function body.
