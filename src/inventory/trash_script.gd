extends HBoxContainer

func _ready():
	visible = false
	Events.connect("open_inventory_show_change_count_slider", vis_on)
	Events.connect("hide_slider_inv", vis_off)
	Events.connect("hide_slider_all", vis_off)

func vis_off():
	visible = false
	
func vis_on():
	visible = true

