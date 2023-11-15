extends Area2D

#здесь мы указываем просто список координат всех
export var coordinates = []

#здесь мы указываем обязательно 2 координаты для того, чтобы прошёлся цикл
export var for_coordinates = []

func _on_Area2D_body_entered(body):
	print("координаты: ", for_coordinates)
	Events.emit_signal("hide_tiles", coordinates, for_coordinates)
	pass # Replace with function body.


func _on_Area2D_body_exited(body):
	Events.emit_signal("show_tiles", coordinates, for_coordinates)
	pass # Replace with function body.
