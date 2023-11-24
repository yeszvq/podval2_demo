extends Sprite

export var item = "apple"

var out = true

func _ready():
	texture = load("res://assets/sprites/items/" + Global.items[item]["icon"])
	pass

func _on_Area2D_body_entered(body):
	out = false
	pass # Replace with function body.

func _input(event):
	if Input.is_action_just_released("action") && out == false:
		if Inventory.add_item(Global.items[item]) == true:
			queue_free()
	pass

func _on_Area2D_body_exited(body):
	out = true
	pass # Replace with function body.
