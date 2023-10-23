extends StaticBody2D

export var item = ""

var out = true
var active = true
var activated = false

func _ready():
	$Sprite.texture = load("res://assets/sprites/items/" + Global.items[item]["icon"])
	pass

func _on_Area2D_body_entered(body):
	out = false
	pass # Replace with function body.

func _input(event):
	if Input.is_action_just_released("action") && out == false:
		#print("я сука")
		if active == true && activated == false:
			Events.emit_signal("start_dialogue", str("test_" + item))
			active = false
			activated = true
		elif active == false && activated == false:
			Events.emit_signal("start_dialogue", "null")
	pass

func _on_Area2D_body_exited(body):
	activated = false
	out = true
	pass # Replace with function body.
