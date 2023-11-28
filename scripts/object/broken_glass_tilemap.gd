extends TileMap

var temp = 0

func _process(delta):
	if temp == 0:
		for cellpose in get_used_cells():
			var cell = get_cell(cellpose.x, cellpose.y)
			var object = load("res://scene/object/broken_glass/broke_glass_" + str(cell) + ".tscn").instance()
			object.position = map_to_world(Vector2(cellpose.x + 1, cellpose.y + 1))
			add_child(object)
			set_cellv(cellpose, -1)
		temp = 1
