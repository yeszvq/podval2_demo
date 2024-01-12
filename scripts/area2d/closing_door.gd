extends Area2D


func _on_Area2D_area_entered(area):
	if Inventory.safepoint != 2:
		Events.emit_signal("walk_stop")
		Events.emit_signal("use_cutscene", "closing_door")
		Inventory.safepoint = 2
		self.queue_free()
	pass # Replace with function body.
