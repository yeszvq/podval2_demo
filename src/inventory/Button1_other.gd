extends Button


func _on_button_up():
	print("вы использовали")
	Events.emit_signal("block_button_inv_off")
	Events.emit_signal("self_destroy_inv_other_menu")
	pass # Replace with function body.
