extends TileMap



func _ready():
	for cellpose in get_used_cells():
		var cell = get_cell(cellpose.x, cellpose.y)
		var object = load("res://scene/object/storage/storage_" + str(cell) + ".tscn").instance()
		object.position = map_to_world(Vector2(cellpose.x + 1, cellpose.y + 1))
		add_child(object)
		set_cellv(cellpose, -1)
	pass # Replace with function body.

