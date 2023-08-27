extends TileMap

#комментарий для проверки пулл реквеста
func _ready():
	Events.connect("hide_layers", hide_layers)
	Events.connect("show_layers", show_layers)
	
func hide_layers():
	set_layer_modulate(1, "#ffffff94")

func show_layers():
	set_layer_modulate(1, "#ffffff")
