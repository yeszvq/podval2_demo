extends TileMap

var previous_tile = []

func _ready():
	Events.connect("hide_tiles", self, "hide_tiles")
	Events.connect("show_tiles", self, "show_tiles")
	pass # Replace with function body.

func hide_tiles(coordinates, for_coordinates):
	for i in coordinates:
		previous_tile.append(get_cellv(i))
		set_cellv(i, -1)
	
	for i in for_coordinates:
		match i[1]:
			0:
				for j in range(i[0].x, i[2].x + 1):
					previous_tile.append(get_cellv(Vector2(j, i[0].y)))
					set_cellv(Vector2(j, i[0].y), -1)
			1:
				for j in range(i[0].y, i[2].y + 1):
					previous_tile.append(get_cellv(Vector2(i[0].x, j)))
					set_cellv(Vector2(i[0].x, j), -1)
	pass
	
func show_tiles(coordinates, for_coordinates):
	for i in coordinates:
		set_cellv(i, previous_tile[0])
		previous_tile.remove(0)
	
	for i in for_coordinates:
		match i[1]:
			0:
				for j in range(i[0].x, i[2].x + 1):
					set_cellv(Vector2(j, i[0].x), previous_tile[0])
					previous_tile.remove(0)
			1:
				for j in range(i[0].y, i[2].y + 1):
					set_cellv(Vector2(i[0].x, j), previous_tile[0])
					previous_tile.remove(0)
	pass