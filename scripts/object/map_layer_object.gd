extends TileMap

var temp = 0
const glass = preload("res://scene/object/broken_glass.tscn")

func _process(delta):
	if temp == 0:
		for cellpose in get_used_cells():
			var cell = get_cell(cellpose.x, cellpose.y)
			if cell == 0:
				var object = glass.instance()
				object.position = map_to_world(cellpose)
				add_child(object)
				set_cellv(cellpose, -1)
		temp = 1
