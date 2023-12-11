extends Area2D

#здесь мы указываем просто список координат всех
export var coordinates = []

#здесь мы указываем обязательно 2 координаты для того, чтобы прошёлся цикл
export var for_coordinates = []

#здесь мы указываем скрываемые факела, они отдельно от предметов из-за настроек
export var torch_on_wall = []

func _on_Area2D_body_entered(body):
	Events.emit_signal("hide_tiles", coordinates, for_coordinates)
	print("work")
	if torch_on_wall != []:
		Events.emit_signal("hide_torch", torch_on_wall)
	pass # Replace with function body.


func _on_Area2D_body_exited(body):
	Events.emit_signal("show_tiles", coordinates, for_coordinates)
	if torch_on_wall != []:
		Events.emit_signal("show_torch", torch_on_wall)
	pass # Replace with function body.
	
func use_hide():
	Events.emit_signal("hide_tiles", coordinates, for_coordinates)
	if torch_on_wall != []:
		Events.emit_signal("hide_torch", torch_on_wall)
	pass
	
func use_show():
	Events.emit_signal("show_tiles", coordinates, for_coordinates)
	if torch_on_wall != []:
		Events.emit_signal("show_torch", torch_on_wall)
	pass

