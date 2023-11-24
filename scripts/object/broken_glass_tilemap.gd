extends TileMap

var temp = 0

func _process(delta):
	if temp == 0:
		for cellpose in get_used_cells():
			var cell = get_cell(cellpose.x, cellpose.y)
			print(cellpose)
			var object = load("res://scene/object/broken_glass/broke_glass_" + str(cell) + ".tscn").instance()
			object.position = map_to_world(Vector2(cellpose.x + 1, cellpose.y + 1))
			print(map_to_world(cellpose))
			add_child(object)
			set_cellv(cellpose, -1)
		temp = 1
