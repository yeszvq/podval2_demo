extends Area2D

export var animation_name = ""
export var alternative_animation_name = ""
var empty = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_area_for_animation_area_entered(area):
	if empty == false:
		Events.emit_signal("use_cutscene", animation_name)
		empty = true
	elif empty == true && alternative_animation_name != "":
		Events.emit_signal("use_cutscene", alternative_animation_name)
		empty = false
	pass # Replace with function body.
