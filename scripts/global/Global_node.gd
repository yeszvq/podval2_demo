extends Node2D

func _ready():
	Events.connect("handle_click_storage", self, "handle_click_storage")
	Global.work_storage = true
	pass # Replace with function body.

func handle_click_storage():
	Global.work_storage = false
	$Timer.start()
	pass

func _on_Timer_timeout():
	Global.work_storage = true
	pass # Replace with function body.
