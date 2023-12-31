extends StaticBody2D


func _ready():
	Events.connect("hide_ocluder", self, "action_0")
	Events.connect("show_ocluder", self, "action_1")
	pass # Replace with function body.
	
func action_0(name):
	get_node(name).visible = false
	pass
	
func action_1(name):
	get_node(name).visible = true
	pass

