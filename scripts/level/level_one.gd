extends Node2D


func _ready():
	
	$YSort/item_2/AudioStreamPlayer.volume_db = Global.last_volume_sound[1]
	$YSort/item_2/AudioStreamPlayer2.volume_db = Global.last_volume_sound[1]
	$YSort/item_2/AudioStreamPlayer3.volume_db = Global.last_volume_sound[1]
	#$AnimationPlayer.play("start")
	Events.connect("show_light", self, "show_light")
	Events.connect("hide_light", self, "hide_light")
	Events.connect("open_menu", self, "pause")
	Events.connect("changed_sound_value", self, "changed_sound_value")
	#Events.connect("hide_menu", self, "unpause")
	
func changed_sound_value(value):
	$YSort/item_2/AudioStreamPlayer.volume_db = Global.last_volume_sound[1]
	$YSort/item_2/AudioStreamPlayer2.volume_db = Global.last_volume_sound[1]
	$YSort/item_2/AudioStreamPlayer3.volume_db = Global.last_volume_sound[1]
	
func pause():
	get_tree().paused = true
	pass # Replace with function body.
	
#func unpause():
	#get_tree().paused = false
	#pass

func show_light():
	$CanvasModulate.visible = true
	$YSort/hero/Light2D2.visible = true
	$YSort/hero/Light2D.visible = true
	
	pass

func hide_light():
	$CanvasModulate.visible = false
	$YSort/hero/Light2D2.visible = false
	$YSort/hero/Light2D.visible = false
	pass
