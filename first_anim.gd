extends Node2D

var last_string = ""
var read = false
var active_0 = true
var count_0 = 0
var count_1 = 0


func _ready():
	$AnimationPlayer.play("work")
	Events.emit_signal("start_music", "first_animo")
	pass # Replace with function body.
	

func _process(delta):
	if read == true && active_0 == true:
		active_0 = false
		if count_0 <= last_string.length() - 1:
			count_0 += 1
			$CanvasLayer/ColorRect/VBoxContainer/HBoxContainer2/Label.visible_characters = count_0
		else:
			read = false
			count_0 = 0
			$AnimationPlayer.play()
			last_string = ""
	elif read == true && active_0 == false:
		if count_1 == 5:
			active_0 = true
			count_1 = 0
		else:
			count_1 = count_1 + 1
	pass
	
func read_text(text):
	active_0 = true
	count_0 = 0
	count_1 = 0
	$AnimationPlayer.stop(false)
	last_string = text
	$CanvasLayer/ColorRect/VBoxContainer/HBoxContainer2/Label.text = text
	read = true
	pass
	
func next_game():
	Events.emit_signal("init_level_after_anim")
	pass


func _on_TextureRect_gui_input(event):
	if event is InputEventMouseButton && event.is_action_released("left_mouse_button"):
		Events.emit_signal("start_sound", "ui_click")
		$AnimationPlayer2.play("stop")
	pass # Replace with function body.
