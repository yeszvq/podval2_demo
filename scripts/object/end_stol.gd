extends Sprite


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("end_stol_change", self, "action")
	pass # Replace with function body.

func action():
	texture = load("res://assets/resourse/end_stol.tres")
	normal_map = load("res://assets/resourse/end_stol_normal.tres")
	position = Vector2(position.x, position.y + 1)
	pass
