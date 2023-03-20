extends Node

class_name Item_Usable

signal start_cooldown(item_usable)
signal cooldown_tick(cooldown_remaining)
signal can_use_changed(can_use)

func _ready():
	pass
