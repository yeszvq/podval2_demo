extends Node2D


func _ready():
	
	$YSort/item_2/AudioStreamPlayer.volume_db = Global.last_volume_sound[1]
	$YSort/item_2/AudioStreamPlayer2.volume_db = Global.last_volume_sound[1]
	$YSort/item_2/AudioStreamPlayer3.volume_db = Global.last_volume_sound[1]
	$YSort/item_2/AudioStreamPlayer2D.volume_db = Global.last_volume_sound[1]
	Events.connect("show_light", self, "show_light")
	Events.connect("hide_light", self, "hide_light")
	Events.connect("open_menu", self, "pause")
	Events.connect("changed_sound_value", self, "changed_sound_value")
	#Events.connect("hide_menu", self, "unpause")
	match Inventory.safepoint:
		0:
			#$AnimationPlayer.play("start")
			print()
		1:
			$YSort/hero.position = Vector2(175, 36)
			$YSort/ne_gosha_1.visible = false
			$YSort/ne_gosha_2.visible = false
			$YSort/ne_gosha_3.visible = false
			Events.emit_signal("zaval")
		2:
			$YSort/hero.position = Vector2(1745, -351)
	pass
func changed_sound_value(value):
	$YSort/item_2/AudioStreamPlayer.volume_db = Global.last_volume_sound[1]
	$YSort/item_2/AudioStreamPlayer2.volume_db = Global.last_volume_sound[1]
	$YSort/item_2/AudioStreamPlayer3.volume_db = Global.last_volume_sound[1]
	$YSort/item_2/AudioStreamPlayer2D.volume_db = Global.last_volume_sound[1]
	
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
