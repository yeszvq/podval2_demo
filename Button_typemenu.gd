extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	add_theme_stylebox_override("normal", get_theme_stylebox("focus"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
