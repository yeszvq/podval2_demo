extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Button2_button_up():
	get_tree().quit()
	pass # Replace with function body.

func _on_Button_button_up():
	Events.emit_signal("start_game")
	pass # Replace with function body.
