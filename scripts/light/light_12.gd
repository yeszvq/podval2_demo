extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("show_light_node", self, "action_0")
	Events.connect("hide_light_node", self, "action_1")
	pass # Replace with function body.


func action_0(name):
	$texture.visible = false
	pass
	
func action_1(name):
	$texture.visible = true
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
