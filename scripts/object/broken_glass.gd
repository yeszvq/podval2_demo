extends Sprite


func _on_Area2D_body_entered(body):
	Inventory.pain_mind_change(0, 10)
	Inventory.limbs_heart.append("legs")
	pass # Replace with function body.
