extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("open_grid_door", self, "open_grid_door")
	Events.connect("close_grid_door", self, "close_grid_door")
	Events.connect("custom_one_change", self, "custom_one_change")
	Events.connect("zaval", self, "zaval_0")
	pass # Replace with function body.
	
func open_grid_door(coordinates):
	for i in coordinates:
		set_cellv(i, int(get_cellv(i)) + 4)
	pass

func close_grid_door(coordinates):
	for i in coordinates:
		set_cellv(i, int(get_cellv(i)) - 4)
	pass
	
func blood_door_0():
	set_cellv(Vector2(31,-29),-1)
	set_cellv(Vector2(32,-29),-1)
	set_cellv(Vector2(33,-29),-1)
	
	set_cellv(Vector2(31,-29),121)
	set_cellv(Vector2(31,-30),122)
	set_cellv(Vector2(32,-31),124)
	set_cellv(Vector2(30,-30),125)
	set_cellv(Vector2(30,-31),126)
	set_cellv(Vector2(33,-29),123)
	pass
	
func broke_wood_door():
	var pos = Vector2(29, 5)
	set_cellv(pos, -1)
	set_cellv(pos, 83)
	pass
	
func custom_one_change(coord, value):
	set_cellv(coord, value)
	pass
	
func zaval_0():
	set_cellv(Vector2(-6,2),28)
	set_cellv(Vector2(-7,2),28)
	set_cellv(Vector2(-6,0),29)
	set_cellv(Vector2(-7,0),29)
	set_cellv(Vector2(-6,1),41)
	set_cellv(Vector2(-7,1),32)
	set_cellv(Vector2(-8,1),41)
	set_cellv(Vector2(-8,0),41)
	pass
