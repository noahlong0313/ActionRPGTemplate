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

func get_item(id : String):
	return items[id].instance()
