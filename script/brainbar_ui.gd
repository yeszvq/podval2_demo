extends TextureProgressBar

func _ready():
	Events.connect("brain_reduct", brain_reduct)
	pass # Replace with function body.

func brain_reduct():
	value -= 1
