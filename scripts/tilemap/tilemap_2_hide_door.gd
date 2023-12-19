extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("open_grid_door", self, "open_grid_door")
	Events.connect("close_grid_door", self, "close_grid_door")
	pass # Replace with function body.
	
func open_grid_door(coordinates):
	for i in coordinates:
		set_cellv(i, int(get_cellv(i)) + 4)
	pass

func close_grid_door(coordinates):
	for i in coordinates:
		set_cellv(i, int(get_cellv(i)) - 4)
	pass
	
func broke_wood_door():
	var pos = Vector2(29, 5)
	set_cellv(pos, -1)
	set_cellv(pos, 83)
	pass
	
func custon_one_change(coord, value):
	set_cellv(coord, value)
	pass
