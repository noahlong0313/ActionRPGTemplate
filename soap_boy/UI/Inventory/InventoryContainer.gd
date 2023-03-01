extends ColorRect

var is_inventory_open = false

func _unhandled_input(event):
	if event.is_action_pressed("inventory"):
		if is_inventory_open == true:
			close_inventory()
		else:
			open_inventory()

func close_inventory():
	get_tree().paused = false
	visible = false
	is_inventory_open = false

func open_inventory():
	get_tree().paused = true
	visible = true
	is_inventory_open = true
