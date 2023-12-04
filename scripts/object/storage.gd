extends StaticBody2D


var dialog = [
	"gosha#Гоша#Я подобрал ",
	"gosha#Гоша#Я не могу больше унести",
	"gosha#Гоша#Тут пусто"
]

var empty = false
var out = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_mouse_click_input_event(viewport, event, shape_idx):
	if Global.work_storage == true && out == true:
		if event is InputEventMouseButton and event.pressed and not event.is_echo() and event.button_index == BUTTON_LEFT:
			Events.emit_signal("handle_click_storage")
			var rng = RandomNumberGenerator.new()
			rng.randomize()
			var temp = rng.randi_range(1,10)
			if temp < 3:
				empty = true
			if empty == true:
				Events.emit_signal("custom_dialog", dialog[2])
			elif empty == false:
				temp = Global.items_loot[rng.randi() % Global.items_loot_get_size()]
				empty = add_item(temp)
	pass
	
func add_item(current_item):
	if Inventory.add_item(Global.items[current_item]) == true:
		Events.emit_signal("custom_dialog", dialog[0] + current_item)
		return true
	else:
		Events.emit_signal("custom_dialog", dialog[1])
		return false
	pass


func _on_mouse_click_mouse_entered():
	print("тест")
	pass # Replace with function body.


func _on_player_nearby_area_entered(area):
	out = true
	pass # Replace with function body.


func _on_player_nearby_area_exited(area):
	out = false
	pass # Replace with function body.
