extends Item

class_name Item_Usable

signal start_cooldown(item_usable)
signal cooldown_tick(cooldown_remaining)

#Consumable
export(int) var health_Restored
export(int) var stamina_Restored
export(int) var mana_Restored

#Cooldown
export(int) var cooldown_time
export(int) var cooldown_remaining

var player
var can_use

var item : Item

func _ready():
	player = get_tree().root.get_node("/root/OverWorld/YSort/Player")

func useItem(target):
	.useItem(target)
	player.health += health_Restored
	player.mana += mana_Restored
	player.stamina += stamina_Restored
