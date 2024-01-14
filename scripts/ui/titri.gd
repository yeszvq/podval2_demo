extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.volume_db = Global.last_volume_sound[0]
	$AnimationPlayer.play("titri")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_button_up():
	Events.emit_signal("back_menu")
	pass # Replace with function body.

func _input(event):
	if Input.is_action_just_released("left_mouse_button"):
		$AnimationPlayer2.play("end")

func end():
	Events.emit_signal("back_menu")
	
func lkm():
	$AnimationPlayer.play("lkm")
	pass
