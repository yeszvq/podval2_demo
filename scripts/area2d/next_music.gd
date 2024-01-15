extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.





func _on_next_music_body_entered(body):
	Events.emit_signal("use_cutscene_2", "music_zal_on")
	self.queue_free()
	pass # Replace with function body.
