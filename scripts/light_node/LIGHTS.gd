extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("hide_light_node", self, "action_0")
	Events.connect("show_light_node", self, "action_1")
	pass # Replace with function body.

func action_0(name):
	match name:
		"tabu_l":
			$tabu_l.visible = true
		"sclad_1":
			$sclad_1.visible = false
		"svecha":
			$svecha.visible = true
	pass
	
func action_1(name):
	match name:
		"tabu_l":
			$tabu_l.visible = false
		"sclad_1":
			$sclad_1.visible = true
		"svecha":
			$svecha.visible = false
	pass

func hide_light():
	visible = false
	pass
	
func show_light():
	visible = true
	pass
