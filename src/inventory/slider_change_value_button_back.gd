extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	Events.connect("hide_slider_inv", hide_slider_inv)
	Events.connect("open_inventory_show_change_count_slider",open_inventory_show_change_count_slider)
	$Button.connect("button_up", button_action)
	Events.connect("hide_slider_all", hide_slider_all)
	Events.connect("open_inventory_hide_slider", open_inventory_hide_slider)
	pass # Replace with function body.

func hide_slider_all():
	visible = false

func button_action():
	visible = false
	Events.emit_signal("hide_slider_inv")

func open_inventory_show_change_count_slider():
	visible = true

func hide_slider_inv():
	visible = false

func open_inventory_hide_slider():
	visible = false
