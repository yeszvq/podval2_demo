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
	
	if value <= 50 && value > 40:
		made_mat(0.25, 0, 0, 0.02)
	elif value <= 40 && value > 30:
		made_mat(0.25, 0.01, 0.01 , 0.02)
	elif value <= 30 && value > 20:
		made_mat(0.3, 0.01, 0.01, 0.02)
	elif value <= 20 && value > 10:
		made_mat(0.3, 0.02, 0.02, 0.02)
	elif value <= 10 && value > 5:
		made_mat(0.35, 0.02, 0.03, 0.03)
	elif value <= 5 && value > 0:
		made_mat(0.4, 0.03, 0.05, 0.05)
	elif value <= 0:
		made_mat(0.4, 0.03, 0.05, 0.05)
	
	if active == false:
		var audio = AudioStreamPlayer.new()
		audio.stream = load("res://assets/sounds/noise_static.ogg")
		audio.volume_db = Global.last_volume_sound[1]
		audio.playing = true
		add_child(audio)
		node = audio
		active = true
	pass

func made_mat(v1,v2,v3,v4):
	var materials = load("res://assets/resourse/mat1.tres")
	materials.set_shader_param("_ScanLineJitter", v1)
	materials.set_shader_param("_VerticalJump", v2)
	materials.set_shader_param("_HorizontalShake", v3)
	materials.set_shader_param("_ColorDrift", v4)
	material = materials
	pass

func action_1():
	visible = false
	
	if active == true:
		var materials = load("res://assets/resourse/mat1.tres")
		materials.set_shader_param("_ScanLineJitter", 0.2)
		materials.set_shader_param("_VerticalJump", 0)
		materials.set_shader_param("_HorizontalShake", 0)
		materials.set_shader_param("_ColorDrift", 0.02)
		material = materials
		remove_child(node)
		active = false
	#param = value_main
	pass
