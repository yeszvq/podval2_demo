extends AnimationPlayer



func _ready():
	Events.connect("start_cutsene", self, "start_cutsene")
	pass # Replace with function body.
	
func start_cutsene(name_cutscene):
	play(name_cutscene)
	pass
