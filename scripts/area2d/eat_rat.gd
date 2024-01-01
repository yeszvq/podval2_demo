extends Area2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_eat_rat_area_entered(area):
	if Inventory.find_item_name("goodRat") != -1 && Inventory.pain_mind[0] > 0:
		Events.emit_signal("use_cutscene", "eat_rat")
		self.queue_free()
	pass # Replace with function body.
