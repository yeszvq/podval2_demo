extends ColorRect

var temp = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if Input.is_action_just_released("esc") && Global.dialog == false && Global.cutscene == false:
		action_0()
	pass

func action_0():
	match temp:
		false:
			$VBoxContainer/TextureRect/MarginContainer/settings/HSlider.value = Global.last_volume_sound[0]
			$VBoxContainer/TextureRect/MarginContainer/settings/HSlider2.value = Global.last_volume_sound[1]
			#Events.emit_signal("start_music", "menu")
			Events.emit_signal("stop_sound")
			Events.emit_signal("walk_stop")
			visible = true
			Global.menu = true
			get_tree().paused = true
			temp = true
		true:
			#Events.emit_signal("start_music", "game")
			visible = false
			Global.menu = false
			get_tree().paused = false
			temp = false
			$VBoxContainer/TextureRect/MarginContainer/buttons.visible = true
			$VBoxContainer/TextureRect/MarginContainer/settings.visible = false
	pass


func _on_HSlider_value_changed(value):
	var temp = $VBoxContainer/TextureRect/MarginContainer/settings/HSlider
	Events.emit_signal("changed_music_value", temp.value)
	pass # Replace with function body.


func _on_HSlider2_value_changed(value):
	var temp = $VBoxContainer/TextureRect/MarginContainer/settings/HSlider2
	Events.emit_signal("changed_sound_value", temp.value)
	pass # Replace with function body.


func _on_HSlider2_drag_started():
	Events.emit_signal("drag_sound_start")
	pass # Replace with function body.


func _on_HSlider2_drag_ended(value_changed):
	Events.emit_signal("drag_sound_stop")
	pass # Replace with function body.


func _on_continue_gui_input(event):
	if event is InputEventMouseButton && event.is_action_released("left_mouse_button"):
		Events.emit_signal("start_sound", "ui_click")
		action_0()
	pass # Replace with function body.


func _on_settings_gui_input(event):
	if event is InputEventMouseButton && event.is_action_released("left_mouse_button"):
			Events.emit_signal("start_sound", "ui_click")
			$VBoxContainer/TextureRect/MarginContainer/buttons.visible = false
			$VBoxContainer/TextureRect/MarginContainer/settings.visible = true
			$VBoxContainer/TextureRect/MarginContainer/settings/HSlider.value = Global.last_volume_sound[0]
			$VBoxContainer/TextureRect/MarginContainer/settings/HSlider2.value = Global.last_volume_sound[1]
	pass # Replace with function body.


func _on_exit_menu_gui_input(event):
	if event is InputEventMouseButton && event.is_action_released("left_mouse_button"):
		Events.emit_signal("start_sound", "ui_click")
		get_tree().paused = false
		Events.emit_signal("back_menu_0")
	pass # Replace with function body.


func _on_exit_gui_input(event):
	if event is InputEventMouseButton && event.is_action_released("left_mouse_button"):
		Events.emit_signal("start_sound", "ui_click")
		get_tree().quit()
	pass # Replace with function body.


func _on_TextureRect3_gui_input(event):
	if event is InputEventMouseButton && event.is_action_released("left_mouse_button"):
		Events.emit_signal("start_sound", "ui_click")
		$VBoxContainer/TextureRect/MarginContainer/buttons.visible = true
		$VBoxContainer/TextureRect/MarginContainer/settings.visible = false
	pass # Replace with function body.
