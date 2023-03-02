extends ColorRect

var is_inventory_open = false
var inventory = preload("res://UI/Inventory/Inventory.tres")

func _ready():
	$NameLabel.text = str(GameState.player_name)

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

func can_drop_data(_position, data):
	return data is Dictionary and data.has("item")

func drop_data(_position, data):
	inventory.set_item(data.item_index, data.item)
