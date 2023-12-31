extends Area2D


func _on_Area2D_area_entered(area):
	Events.emit_signal("walk_stop")
	Events.emit_signal("use_cutscene", "closing_door")
	self.queue_free()
	pass # Replace with function body.
