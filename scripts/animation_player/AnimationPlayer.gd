extends AnimationPlayer



func _ready():
	Events.connect("start_cutsene", self, "start_cutsene")
	Events.connect("use_stop_cutscene", self, "use_stop")
	Events.connect("use_start_cutscene", self, "use_start")
	pass # Replace with function body.
	
func start_cutsene(name_cutscene):
	play(name_cutscene)
	pass

func use_stop():
	stop(false)
	pass
	
func use_start():
	play()
	pass
