extends Inventory_Slot

class_name Hotbar_Slot

onready var labelKey = $Label_Key

var key

func _ready():
	labelKey.text = key

func _input(event):
	if event.is_action_pressed("use_" + key) and is_instance_valid(item) and item.USEABLE == true and item.in_cooldown == false:
		print("used hotbar slot: ", key)
		item.useItem(item)
