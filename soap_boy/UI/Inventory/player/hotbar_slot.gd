extends Inventory_Slot

class_name Hotbar_Slot

onready var labelKey = $Label_Key

var key

func _ready():
	labelKey.text = key

func _input(event):
	if event.is_action_pressed("use_" + key):
		print("used hotbar slot: ", key)
