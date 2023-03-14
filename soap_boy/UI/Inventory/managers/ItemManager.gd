extends Node

var items_Path = "res://Items/JSON/item.json"

var items = {}

onready var placeholders = {
	GameEnums.EQUIPMENT_TYPE.ACCESSORY : preload("res://UI/Inventory/sprites/placeholder_accessory.png"),
	GameEnums.EQUIPMENT_TYPE.WEAPON : preload("res://UI/Inventory/sprites/placeholder_weapon.png"),
	GameEnums.EQUIPMENT_TYPE.MAGIC_1 : preload("res://UI/Inventory/sprites/placeholder_magic_1.png"),
	GameEnums.EQUIPMENT_TYPE.MAGIC_2 : preload("res://UI/Inventory/sprites/placeholder_magic_2.png")
}

func _ready():
	var file = File.new()
	file.open(items_Path, File.READ)
	items = parse_json(file.get_as_text())
	file.close()

func get_item(id : String):
	return Item.new(id, items[id])

func get_placeholder(id):
	return placeholders[id]
