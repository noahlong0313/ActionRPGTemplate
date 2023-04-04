extends Node

onready var items = {
	#Accesories
	"ring_diamond" : preload("res://Items/Items/diamond_ring.tscn"),
	"ring_drain" : preload("res://Items/Items/drain_ring.tscn"),
	
	#Items
	"potion_health" : preload("res://Items/Items/potion_health.tscn"),
	"potion_mana" : preload("res://Items/Items/potion_mana.tscn"),
	"potion_stamina" : preload("res://Items/Items/potion_stamina.tscn"),
	
	#Weapons
	"sword_iron" : preload("res://Items/Items/sword_iron.tscn"),
	
	#Armor
	"shield_tall" : preload("res://Items/Items/shield_tall.tscn"),
	
	#Books
	"tome_B_health_Self" : preload("res://Items/Items/tome_B_health_Self.tscn"),
	"tome_G_damage_AoE" : preload("res://Items/Items/tome_G_damage_AoE.tscn"),
	"tome_R_damage_Touch" : preload("res://Items/Items/tome_R_damage_Touch.tscn"),
	"tome_Y_health_Self" : preload("res://Items/Items/tome_Y_health_Self.tscn"),
	"tome_Y_speed_Self" : preload("res://Items/Items/tome_Y_speed_Self.tscn")
}

onready var placeholders = {
	GameEnums.EQUIPMENT_TYPE.ACCESSORY : preload("res://UI/Inventory/sprites/placeholder_accessory.png"),
	GameEnums.EQUIPMENT_TYPE.WEAPON : preload("res://UI/Inventory/sprites/placeholder_weapon.png"),
	GameEnums.EQUIPMENT_TYPE.MAGIC_1 : preload("res://UI/Inventory/sprites/placeholder_magic_1.png"),
	GameEnums.EQUIPMENT_TYPE.MAGIC_2 : preload("res://UI/Inventory/sprites/placeholder_magic_2.png")
}

var tscn = {
	"floor_item": preload("res://Items/Interactables/floor_item.tscn"),
	"hotbar_slot": preload("res://UI/Inventory/player/hotbar_slot.tscn")
}

func get_item( id : String ):
	return items[id].instance()

func get_placeholder(id):
	return placeholders[id]
