extends ColorRect

var node
var active = false
const value_main = 0.01
func _ready():
	Events.connect("low_mind", self, "action_0")
	Events.connect("more_mind", self, "action_1")
	pass
	
func action_0(value = 50):
	visible = true
	
	var temp = (
		0.25 if value > 25
		else 0.3 if value >= 10
		else 0.4 if value < 10
		else 0.2
	)
	
	var materials = load("res://assets/resourse/mat1.tres")
	materials.set_shader_param("_ScanLineJitter", temp)
	material = materials
	
	if active == false:
		var audio = AudioStreamPlayer.new()
		audio.stream = load("res://assets/sounds/noise_static.ogg")
		audio.volume_db = Global.last_volume_sound[1]
		audio.playing = true
		add_child(audio)
		node = audio
		active = true
	pass

func action_1():
	visible = false
	
	if active == true:
		var materials = load("res://assets/resourse/mat1.tres")
		materials.set_shader_param("_ScanLineJitter", 0.2)
		material = materials
		remove_child(node)
		active = false
	#param = value_main
	pass
