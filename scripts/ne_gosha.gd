extends KinematicBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func exit():
	self.queue_free()
	pass
	
func hide():
	visible = false
	pass
	
func play_anim(name):
	$AnimatedSprite.play(name)
	pass
