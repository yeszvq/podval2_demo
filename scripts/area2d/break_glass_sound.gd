extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_break_glass_sound_area_entered(area):
	Events.emit_signal("walk_type", "walk_glass")
	pass # Replace with function body.


func _on_break_glass_sound_area_exited(area):
	Events.emit_signal("walk_type", "walk")
	pass # Replace with function body.
