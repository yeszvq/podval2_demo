extends Area2D

func _ready():
	pass # Replace with function body.




func _on_dark_area_on_area_entered(area):
	Events.emit_signal("dark_on")
	pass # Replace with function body.


func _on_dark_area_off_area_entered(area):
	Events.emit_signal("dark_off")
	pass # Replace with function body.
