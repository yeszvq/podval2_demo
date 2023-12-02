extends Area2D

export (String, "Random", "Definite") var type_loot
export var item = ""

var out = true
var empty = false

var dialog = [
	"gosha#Гоша#Я подобрал ",
	"gosha#Гоша#Я не могу больше унести",
	"gosha#Гоша#Тут пусто"
]

func _ready():
	pass

func _input(event):
	if Input.is_action_just_released("action") && out == false:
		#Необходимо написать код который добавит игроку нужный предмет в инвентарь
		if empty == true:
			Events.emit_signal("custom_dialog", dialog[2])
		elif type_loot == "Random":
			var temp = Global.items_loot[randi() % Global.items_loot_get_size()]
			empty = add_item(temp)
		else:
			add_item(item)
	pass
	
func add_item(current_item):
	if Inventory.add_item(Global.items[current_item]) == true:
		Events.emit_signal("custom_dialog", dialog[0] + current_item)
		return true
	else:
		Events.emit_signal("custom_dialog", dialog[1])
		return false
	pass

func _on_Area2D_body_exited(body):
	out = true
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	out = false
	pass # Replace with function body.
