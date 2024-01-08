extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/MarginContainer/TextureRect/MarginContainer/VBoxContainer/HBoxContainer/settings/MarginContainer/VBoxContainer/HSlider.value = Global.last_volume_sound[0]
	$CanvasLayer/MarginContainer/TextureRect/MarginContainer/VBoxContainer/HBoxContainer/settings/MarginContainer/VBoxContainer/HSlider2.value = Global.last_volume_sound[1]
	pass # Replace with function body.


func _on_Button2_button_up():
	Events.emit_signal("start_sound", "ui_click")
	get_tree().quit()
	pass # Replace with function body.

func _on_Button_button_up():
	Events.emit_signal("start_sound", "ui_click")
	Events.emit_signal("start_game")
	pass # Replace with function body.


func _on_Button4_button_up():
	Events.emit_signal("start_sound", "ui_click")
	Events.emit_signal("end_game_1")
	pass # Replace with function body.


func _on_Button3_button_up():
	Events.emit_signal("start_sound", "ui_click")
	$CanvasLayer/MarginContainer/TextureRect/MarginContainer/VBoxContainer/HBoxContainer/buttons.visible = false
	$CanvasLayer/MarginContainer/TextureRect/MarginContainer/VBoxContainer/HBoxContainer/settings.visible = true
	$CanvasLayer/MarginContainer/TextureRect/MarginContainer/VBoxContainer/HBoxContainer/settings/MarginContainer/VBoxContainer/HSlider.value = Global.last_volume_sound[0]
	$CanvasLayer/MarginContainer/TextureRect/MarginContainer/VBoxContainer/HBoxContainer/settings/MarginContainer/VBoxContainer/HSlider2.value = Global.last_volume_sound[1]
	pass # Replace with function body.


func _on_Button_ok_button_up():
	Events.emit_signal("start_sound", "ui_click")
	$CanvasLayer/MarginContainer/TextureRect/MarginContainer/VBoxContainer/HBoxContainer/buttons.visible = true
	$CanvasLayer/MarginContainer/TextureRect/MarginContainer/VBoxContainer/HBoxContainer/settings.visible = false
	pass # Replace with function body.


func _on_HSlider_value_changed(value):
	var temp = $CanvasLayer/MarginContainer/TextureRect/MarginContainer/VBoxContainer/HBoxContainer/settings/MarginContainer/VBoxContainer/HSlider
	Events.emit_signal("changed_music_value", temp.value)
	pass # Replace with function body.


func _on_HSlider2_value_changed(value):
	var temp = $CanvasLayer/MarginContainer/TextureRect/MarginContainer/VBoxContainer/HBoxContainer/settings/MarginContainer/VBoxContainer/HSlider2
	Events.emit_signal("changed_sound_value", temp.value)
	pass # Replace with function body.

func _on_HSlider2_drag_started():
	Events.emit_signal("drag_sound_start")
	pass # Replace with function body.


func _on_HSlider2_drag_ended(value_changed):
	Events.emit_signal("drag_sound_stop")
	pass # Replace with function body.
