extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	Events.connect("call_test_panel", self, "show_hide")
	pass # Replace with function body.

func show_hide():
	if visible == false:
		visible = true
	elif visible == true:
		visible = false


func _on_CheckButton_toggled(button_pressed):
	if button_pressed == true:
		Events.emit_signal("show_light")
	else:
		Events.emit_signal("hide_light")
	pass # Replace with function body.


func _on_Button_button_up():
	Inventory.pain_mind[1] = 0
	pass # Replace with function body.
