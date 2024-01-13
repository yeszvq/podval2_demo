extends ColorRect

var active = false
var node

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("low_pain", self, "action_0")
	Events.connect("more_pain", self, 'action_1')
	pass # Replace with function body.


func action_0(value = 0):
	#visible = true
	
	var temp = (
		1 if value <= 20
		else 1 if value <= 40
		else 1 if value <= 60
		else 1 if value <= 80
		else 1 if value <= 100
		else 1
	)
	
	var materials = load("res://assets/resourse/mt2.tres")
	materials.set_shader_param("SCALE", temp)
	material = materials
	
	if active == false:
		var audio = AudioStreamPlayer.new()
		audio.stream = load("res://assets/sounds/heartbeat.ogg")
		audio.volume_db = Global.last_volume_sound[1]
		audio.playing = true
		add_child(audio)
		node = audio
		active = true
		Events.emit_signal("use_cutscene", "pain_on")
	pass

func action_1():
	#visible = false
	
	if active == true:
		print("work")
		var materials = load("res://assets/resourse/mt2.tres")
		materials.set_shader_param("SCALE", 1)
		material = materials
		remove_child(node)
		active = false
		Events.emit_signal("use_cutscene", "pain_off")
	#param = value_main
	pass
