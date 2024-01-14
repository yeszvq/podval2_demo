extends Area2D


func _ready():
	Events.connect("respawn", self, "respawn")
	pass # Replace with function body.

func respawn():
	self.queue_free()
	pass

func _on_Area2D2_body_entered(body):
	Events.emit_signal("use_cutscene_1", "learn_3_on")
	self.queue_free()
	pass # Replace with function body.
