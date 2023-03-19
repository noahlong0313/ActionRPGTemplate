extends Area2D

class_name Chest

export(int) var size = 1
export(String) var inventory_name
export(Array, String) var items

var inventory : Inventory
var action = "open"
var object_name = ""

func _init():
	inventory = preload("res://UI/Inventory/inventory.tscn").instance()

func _ready():
	inventory.size = size
	inventory.inventory_name = inventory_name
	object_name = inventory_name
	set_items()

func set_items():
	for i in items:
		inventory.add_item(ItemManager.get_item(i))

func interact():
	InvSignalManager.emit_signal("inventory_opened", inventory)

func out_of_range():
	if inventory.is_open:
		InvSignalManager.emit_signal("inventory_closed", inventory)
