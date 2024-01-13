extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/MarginContainer/TextureRect/MarginContainer/VBoxContainer/HBoxContainer/TextureRect/MarginContainer/settings/HSlider.value = Global.last_volume_sound[0]
	$CanvasLayer/MarginContainer/TextureRect/MarginContainer/VBoxContainer/HBoxContainer/TextureRect/MarginContainer/settings/HSlider2.value = Global.last_volume_sound[1]
	pass # Replace with function body.

func _on_HSlider_value_changed(value):
	var temp = $CanvasLayer/MarginContainer/TextureRect/MarginContainer/VBoxContainer/HBoxContainer/TextureRect/MarginContainer/settings/HSlider
	Events.emit_signal("changed_music_value", temp.value)
	pass # Replace with function body.


func _on_HSlider2_value_changed(value):
	var temp = $CanvasLayer/MarginContainer/TextureRect/MarginContainer/VBoxContainer/HBoxContainer/TextureRect/MarginContainer/settings/HSlider2
	Events.emit_signal("changed_sound_value", temp.value)
	pass # Replace with function body.

func _on_HSlider2_drag_started():
	Events.emit_signal("drag_sound_start")
	pass # Replace with function body.


func _on_HSlider2_drag_ended(value_changed):
	Events.emit_signal("drag_sound_stop")
	pass # Replace with function body.


func _on_play_gui_input(event):
	if event is InputEventMouseButton && event.is_action_released("left_mouse_button"):
		Events.emit_signal("start_sound", "ui_click")
		Events.emit_signal("start_game")
	pass # Replace with function body.


func _on_settings_gui_input(event):
	if event is InputEventMouseButton && event.is_action_released("left_mouse_button"):
		Events.emit_signal("start_sound", "ui_click")
		$CanvasLayer/MarginContainer/TextureRect/MarginContainer/VBoxContainer/HBoxContainer/TextureRect/MarginContainer/buttons.visible = false
		$CanvasLayer/MarginContainer/TextureRect/MarginContainer/VBoxContainer/HBoxContainer/TextureRect/MarginContainer/settings.visible = true
		$CanvasLayer/MarginContainer/TextureRect/MarginContainer/VBoxContainer/HBoxContainer/TextureRect/MarginContainer/settings/HSlider.value = Global.last_volume_sound[0]
		$CanvasLayer/MarginContainer/TextureRect/MarginContainer/VBoxContainer/HBoxContainer/TextureRect/MarginContainer/settings/HSlider2.value = Global.last_volume_sound[1]
	pass # Replace with function body.


func _on_titri_gui_input(event):
	if event is InputEventMouseButton && event.is_action_released("left_mouse_button"):
		Events.emit_signal("start_sound", "ui_click")
		Events.emit_signal("end_game_1")
	pass # Replace with function body.


func _on_exit_gui_input(event):
	if event is InputEventMouseButton && event.is_action_released("left_mouse_button"):
		Events.emit_signal("start_sound", "ui_click")
		get_tree().quit()
	pass # Replace with function body.


func _on_ok_gui_input(event):
	if event is InputEventMouseButton && event.is_action_released("left_mouse_button"):
		Events.emit_signal("start_sound", "ui_click")
		$CanvasLayer/MarginContainer/TextureRect/MarginContainer/VBoxContainer/HBoxContainer/TextureRect/MarginContainer/buttons.visible = true
		$CanvasLayer/MarginContainer/TextureRect/MarginContainer/VBoxContainer/HBoxContainer/TextureRect/MarginContainer/settings.visible = false
	pass # Replace with function body.
