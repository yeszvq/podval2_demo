extends StaticBody2D

var out = false

export var item = ""

var dialog = [
	"gosha#Гоша#Я подобрал ",
	"gosha#Гоша#Я не могу больше унести",
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_mouse_input_event(viewport, event, shape_idx):
	if Global.work_item == true && out == true:
		if event is InputEventMouseButton and event.pressed and not event.is_echo() and event.button_index == BUTTON_LEFT:
			Events.emit_signal("handle_click_storage")
			add_item(item)
	pass # Replace with function body.
	
func add_item(current_item):
	if Inventory.add_item(Global.items[current_item]) == true:
		Events.emit_signal("custom_dialog", dialog[0] + current_item["name"])
		queue_free()
		return true
	else:
		Events.emit_signal("custom_dialog", dialog[1])
		return false
	pass

func _on_player_nearby_area_entered(area):
	z_index = 99
	out = true
	pass # Replace with function body.


func _on_player_nearby_area_exited(area):
	z_index = 1
	out = false
	pass # Replace with function body.
