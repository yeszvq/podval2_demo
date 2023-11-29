extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("coord_player", self, "test")
	pass # Replace with function body.
	
func test(coord):
	Events.emit_signal("coord_player2", world_to_map(coord))
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
