extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.





func _on_Area2D_body_entered(body):
	Events.emit_signal("hide_light_hero")
	pass # Replace with function body.


func _on_Area2D_body_exited(body):
	Events.emit_signal("show_light_hero")
	pass # Replace with function body.
