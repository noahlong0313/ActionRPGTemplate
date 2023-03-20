extends Node

onready var items = {
	#Accesories
	"ring_diamond" : preload("res://Items/Items/diamond_ring.tscn"),
	
	#Items
	"potion_health" : preload("res://Items/Items/potion_health.tscn"),
	
	#Weapons
	"sword_iron" : preload("res://Items/Items/sword_iron.tscn"),
	
	#Armor
	"shield_tall" : preload("res://Items/Items/shield_tall.tscn"),
	
	#Books
	"tome_fire" : preload("res://Items/Items/tome_fire.tscn")
}

onready var placeholders = {
	GameEnums.EQUIPMENT_TYPE.ACCESSORY : preload("res://UI/Inventory/sprites/placeholder_accessory.png"),
	GameEnums.EQUIPMENT_TYPE.WEAPON : preload("res://UI/Inventory/sprites/placeholder_weapon.png"),
	GameEnums.EQUIPMENT_TYPE.MAGIC_1 : preload("res://UI/Inventory/sprites/placeholder_magic_1.png"),
	GameEnums.EQUIPMENT_TYPE.MAGIC_2 : preload("res://UI/Inventory/sprites/placeholder_magic_2.png")
}

var container = {
	"floor_item": preload("res://Items/Interactables/floor_item.tscn")
}

func get_item( id : String ):
	return items[id].instance()

func get_placeholder(id):
	return placeholders[id]
