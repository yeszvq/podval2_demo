extends CharacterBody2D

@export var speed = 50
var frames
var light
var grid
var last_direction = Vector2(0,1)
var input_direction
var open_inventory = false
 
func _ready():
	frames = get_node("AnimatedSprite2D")


#Передвижение и проигрывание анимаций движения или простоя
#P.s: надо найти более оптимизированный вариант реализации
func get_input():
	input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	if input_direction.x > 0 && input_direction.y > 0:
		frames.play("down_right")
		last_direction = Vector2(1,1)
	elif input_direction.x < 0 && input_direction.y > 0:
		frames.play("down_left")
		last_direction = Vector2(-1,1)
	elif input_direction.x > 0 && input_direction.y < 0:
		frames.play("up_right")
		last_direction = Vector2(1,-1)
	elif input_direction.x < 0 && input_direction.y < 0:
		frames.play("up_left")
		last_direction = Vector2(-1,-1)
	elif input_direction.x == 1:
		frames.play("right")
		last_direction = Vector2(1,0)
	elif input_direction.x == -1:
		frames.play("left")
		last_direction = Vector2(-1,0)
	elif input_direction.y == 1:
		frames.play("down")
		last_direction = Vector2(0,1)
	elif input_direction.y == -1:
		frames.play("up")
		last_direction = Vector2(0,-1)
	elif input_direction == Vector2(0,0):
		match last_direction:
			Vector2(1,1):
				frames.play("idle_down_right")
			Vector2(-1,1):
				frames.play("idle_down_left")
			Vector2(1,-1):
				frames.play("idle_up_right")
			Vector2(-1,-1):
				frames.play("idle_up_left")
			Vector2(1,0):
				frames.play("idle_right")
			Vector2(-1,0):
				frames.play("idle_left")
			Vector2(0,1):
				frames.play("idle_down")
			Vector2(0,-1):
				frames.play("idle_up")
		
#Функциональные кнопки
func _input(event):
	if event.is_action_released("test_button"):
		Inventory.set_item(Global.items["apple"], 0)
	if event.is_action_released("test_button_2"):
		Inventory.set_item(Global.items["sword"], 1)
	if event.is_action_released("open_invetory"):
		Events.emit_signal("open_inventory")

func _physics_process(delta):
	get_input()
	move_and_slide()


#Функции отвечающие за прозрачность стен взависимости от расстояния персонажа до них
func _on_area_2d_body_entered(body):
	Events.emit_signal("hide_layers")
	pass # Replace with function body.


func _on_area_2d_body_exited(body):
	Events.emit_signal("show_layers")
	pass # Replace with function body.
