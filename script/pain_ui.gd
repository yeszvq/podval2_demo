extends TextureProgressBar


func _ready():
	Events.connect("pain_increase", pain_increase)

func pain_increase():
	value += 5
