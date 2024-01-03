extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_zal_area_entered(area):
	Events.emit_signal("hide_light_node", "tabu_l")
	pass # Replace with function body.


func _on_zal_area_exited(area):
	Events.emit_signal("show_light_node", "tabu_l")
	pass # Replace with function body.
