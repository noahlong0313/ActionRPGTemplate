extends Button

class_name Chest

export(int) var size = 1
export(String) var inventory_name
export(Array, String) var items

var inventory : Inventory

func _init():
	inventory = preload("res://UI/Inventory/inventory.tscn").instance()

func _ready():
	inventory.size = size
	inventory.inventory_name = inventory_name
	set_items()

func set_items():
	for i in items:
		inventory.add_item(ItemManager.get_item(i))

func _on_Button_pressed():
	InvSignalManager.emit_signal("inventory_opened", inventory)