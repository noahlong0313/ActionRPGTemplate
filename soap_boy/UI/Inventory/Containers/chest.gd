extends StaticBody2D

class_name Chest

export(int) var size = 1
export(String) var inventory_name
export(Array, String) var items

var inventory : Inventory
var can_interact = false

func _init():
	inventory = preload("res://UI/Inventory/inventory.tscn").instance()

func _ready():
	inventory.size = size
	inventory.inventory_name = inventory_name
	set_items()

func set_items():
	for i in items:
		inventory.add_item(ItemManager.get_item(i))

func _unhandled_input(event):
	if Input.is_action_just_pressed("interact") and can_interact == true:
		InvSignalManager.emit_signal("inventory_opened", inventory)

func _on_InteractArea2D_body_entered(body):
	if body.name == "Player":
		can_interact = true

func _on_InteractArea2D_body_exited(body):
	if body.name == "Player":
		can_interact = true
