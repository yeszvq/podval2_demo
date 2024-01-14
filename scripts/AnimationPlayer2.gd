extends AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("use_cutscene_1", self, "plays")
	Events.connect("usecutsce", self, "act_0")
	pass # Replace with function body.

func act_0():
	plays("learn_2_on")
	pass

func plays(name):
	play(name)
	pass
