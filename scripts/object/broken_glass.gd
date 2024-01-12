extends Sprite


func _on_Area2D_body_entered(body):
	Inventory.pain_mind_change(0, 4)
	Inventory.add_heart("legs")
	pass # Replace with function body.
