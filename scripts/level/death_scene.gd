extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("start")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureRect_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_action_released("left_mouse_button"):
			$AnimationPlayer.play("restart")
			Inventory.pain_mind[0] = 0
			Inventory.pain_mind[1] = 100
			Inventory.items = []
	pass # Replace with function body.


func _on_TextureRect2_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_action_released("left_mouse_button"):
			Events.emit_signal("back_menu_1")
	pass # Replace with function body.
	
func again():
	Events.emit_signal("again")
	pass
