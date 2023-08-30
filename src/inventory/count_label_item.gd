extends PanelContainer

func _ready():
	visible = false
	Events.connect("open_inventory_show_change_count_slider", vis_on)
	
func vis_on():
	$Label.text = str(0)
	visible = true
		
func vis_off():
	visible = false


func _on_h_slider_value_changed(value):
	$Label.text = str(value)
	pass # Replace with function body.
