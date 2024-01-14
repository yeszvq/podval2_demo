extends Area2D

export var name_map = ""
export var safepoint = 1
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("respawn", self, "respawn")
	pass # Replace with function body.

func respawn():
	if safepoint == 1:
		self.queue_free()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_area_entered(area):
	Events.emit_signal("start_sound", "page")
	Events.emit_signal("map_new_list",name_map)
	Inventory.safepoint = safepoint
	self.queue_free()
	pass # Replace with function body.
