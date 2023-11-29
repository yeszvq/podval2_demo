extends TileMap


var previous_tile = []


func _ready():
	Events.connect("hide_torch", self, "hide_torch")
	Events.connect("show_torch", self, "show_torch")
	pass # Replace with function body.

func hide_torch(coordinates):
	for i in coordinates:
		previous_tile.append(get_cellv(i))
		set_cellv(i, -1)
	pass
	
func show_torch(coordinates):
	for i in coordinates:
		set_cellv(i, previous_tile[0])
		previous_tile.remove(0)
	pass
