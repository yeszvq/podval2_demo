extends CanvasLayer



# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("coord_player2", self, "test")
	pass # Replace with function body.

func test(coord):
	$PanelContainer/VBoxContainer/Label.text = str(coord)
	pass

func process():
	pass
