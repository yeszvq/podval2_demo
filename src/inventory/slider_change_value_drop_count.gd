extends VBoxContainer

var index_ItemSlot

func _ready():
	visible = false
	Events.connect("open_inventory_show_change_count_slider",open_inventory_show_change_count_slider)
	Events.connect("hide_slider_inv", hide_slider_inv)
	$Button.connect("button_up",  button_action)
	Events.connect("open_inventory_move_index_itemslot", open_inventory_move_index_itemslot)
	Events.connect("open_inventory_hide_slider", open_inventory_hide_slider)

func button_action():
	visible = false
	Inventory.remove_item_count(index_ItemSlot, $HSlider.value)
	$HSlider.value = 0
	Events.emit_signal("hide_slider_all")
	Events.emit_signal("open_inventory_hide_border")

func open_inventory_show_change_count_slider():
	$HSlider.max_value = Inventory.items[index_ItemSlot]["count"]
	visible = true

func hide_slider_inv():
	visible = false

func open_inventory_move_index_itemslot(index):
	index_ItemSlot = index

func open_inventory_hide_slider():
	visible = false
