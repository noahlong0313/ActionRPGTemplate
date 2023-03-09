extends Node

onready var items = {
	#Accesories
	"ring_diamond" : preload("res://Items/item/diamondring.tscn"),
	
	#Items
	"potion_health" : preload("res://Items/item/healthpotion.tscn"),
	
	#Weapons
	"sword_iron" : preload("res://Items/item/ironsword.tscn"),
	
	#Armor
	"shield_tall" : preload("res://Items/item/tallshield.tscn"),
	
	#Books
	"tome_fire" : preload("res://Items/item/firebook.tscn")
}

onready var placeholders = {
	GameEnums.EQUIPMENT_TYPE.ACCESSORY : preload("res://UI/Inventory/sprites/placeholder_accessory.png"),
	GameEnums.EQUIPMENT_TYPE.WEAPON : preload("res://UI/Inventory/sprites/placeholder_weapon.png"),
	GameEnums.EQUIPMENT_TYPE.MAGIC_1 : preload("res://UI/Inventory/sprites/placeholder_magic_1.png"),
	GameEnums.EQUIPMENT_TYPE.MAGIC_2 : preload("res://UI/Inventory/sprites/placeholder_magic_2.png")
}

func get_item(id : String):
	return items[id].instance()

func get_placeholder(id):
	return placeholders[id]
