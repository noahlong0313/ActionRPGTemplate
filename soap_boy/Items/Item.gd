extends TextureRect

class_name Item

#Base Stats
export(String) var id
export(String) var item_name
export(String, MULTILINE) var item_desc
export(GameEnums.EQUIPMENT_TYPE) var equipment_type
export(int) var quantity: int setget set_quantity
export(int) var stack_size

#Consumable
export(int) var health_Restored
export(int) var stamina_Restored
export(int) var mana_Restored

#Equipment
## Weapons / Attacks
export(int) var damage
export(float) var stamina_drain
export(float) var mana_drain
## Movement
export(int) var player_Speed_Increase
export(int) var player_Speed_Decrease
## Max Stats
export(int) var max_Health_Increase
export(int) var max_Health_Decrease
export(int) var max_Stamina_Increase
export(int) var max_Stamina_Decrease
export(int) var max_Mana_Increase
export(int) var max_Mana_Decrease
## Reg Stats
export(float) var reg_Health_Increase
export(float) var reg_Health_Decrease
export(float) var reg_Stamina_Increase
export(float) var reg_Stamina_Decrease
export(float) var reg_Mana_Increase
export(float) var reg_Mana_Decrease

onready var quantity_label: Label = $quantity_label

func _ready():
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	set_quantity(quantity)

func set_quantity(new_value: int) -> void:
	quantity = new_value
	if is_instance_valid(quantity_label):
		$quantity_label.text = str(quantity)
		$quantity_label.visible = quantity > 1

func add_item_quantity(value):
	var remainder = quantity + value - stack_size
	quantity = min(quantity + value, stack_size)
	set_quantity(quantity)
	return remainder
