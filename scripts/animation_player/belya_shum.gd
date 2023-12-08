extends AnimatedSprite

var show = false
var hide = false
var temp = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func use_hide():
	visible = false
	pass

func use_show():
	visible = true
	pass
	
	
func move_show():
	show = true
	pass
	
func move_hide():
	hide = true
	pass
	
func stop_hide():
	hide = false
	pass
	
func stop_show():
	show = false
	pass

func exit():
	self.queue_free()
	pass


func _process(delta):
	if hide == true:
		if temp >= 0:
			temp = temp - 1 * delta
			modulate = Color(1, 1, 1, temp)
		else:
			hide = false
	elif show == true:
		if temp <= 0.99:
			temp = temp + 1 * delta
			modulate = Color(1, 1, 1, temp)
		else:
			print("false_shpw")
			show = false
	pass
