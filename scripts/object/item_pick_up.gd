extends Sprite

export var item = "apple"

var out = true

func _ready():
	texture = load("res://assets/sprites/items/" + Global.items[item]["icon"])
	pass

func _on_Area2D_body_entered(body):
	out = false
	Events.emit_signal("znak_show")
	pass # Replace with function body.

func _input(event):
	if Input.is_action_just_released("action") && out == false:
		Events.emit_signal("znak_hide")
		Inventory.add_item(Global.items[item])
		queue_free()
	pass

func _on_Area2D_body_exited(body):
	out = true
	Events.emit_signal("znak_hide")
	pass # Replace with function body.
