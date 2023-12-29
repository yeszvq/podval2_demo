extends TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func open_door():
	set_cellv(Vector2(31,-75),-1)
	set_cellv(Vector2(32,-75),-1)
	set_cellv(Vector2(33,-75),-1)
	set_cellv(Vector2(31,-75),112)
	set_cellv(Vector2(31,-76),113)
	pass

func open_door_1():
	set_cellv(Vector2(31,-75),-1)
	set_cellv(Vector2(32,-75),-1)
	set_cellv(Vector2(33,-75),-1)
	set_cellv(Vector2(31,-76),113)
	set_cellv(Vector2(31,-75),112)
	pass
