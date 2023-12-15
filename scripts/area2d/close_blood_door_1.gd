extends Area2D


var empty = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_close_blood_door_1_area_entered(area):
	if empty == false:
		Events.emit_signal("use_cutscene", "blood_door_1_close")
		empty = true
	pass # Replace with function body.
