extends TextureRect

class_name Item

signal item_depleted

#Base Stats
export(bool) var USEABLE

export(String) var id
export(String) var item_name
export(String, MULTILINE) var item_desc
export(GameEnums.EQUIPMENT_TYPE) var equipment_type
export(int) var quantity: int setget set_quantity
export(int) var stack_size

#Equipment
## Weapons / Attacks
export(int) var damage
export(float) var stamina_drain
export(float) var mana_drain
## Movement
export(int) var player_Speed_Change
## Max Stats
export(int) var max_Health_Change
export(int) var max_Stamina_Change
export(int) var max_Mana_Change
## Reg Stats
export(float) var reg_Health_Change
export(float) var reg_Stamina_Change
export(float) var reg_Mana_Change

onready var quantity_label: Label = $quantity_label

var item_slot

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

func decreaseQuantity():
	quantity -= 1
	if quantity <= 0:
		emit_signal("item_depleted", self)
		destroy()
	set_quantity(quantity)

func useItem(target):
	decreaseQuantity()

func destroy():
	queue_free()
