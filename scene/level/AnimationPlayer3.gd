extends AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("use_cutscene_2", self, "plays")
	pass # Replace with function body.

func plays(name):
	play(name)
	pass
