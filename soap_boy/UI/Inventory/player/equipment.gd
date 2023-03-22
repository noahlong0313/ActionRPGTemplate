extends Inventory

export(NodePath) onready var accessory = get_node(accessory) as Inventory_Slot
export(NodePath) onready var weapon = get_node(weapon) as Inventory_Slot
export(NodePath) onready var magic_1 = get_node(magic_1) as Inventory_Slot
export(NodePath) onready var magic_2 = get_node(magic_2) as Inventory_Slot

var weapon_damage

var item : Item

func _ready():
	slots.append(accessory)
	slots.append(weapon)
	slots.append(magic_1)
	slots.append(magic_2)
	InvSignalManager.emit_signal("inventory_ready", self)

func set_inventory_size(value):
	size = value

func calculate_equipment_stat():
	if slots[1].item:
		return slots[1].item.damage
	else:
		return str("invalid, no item")

func get_equipment_stat():
	var weapon_damage = calculate_equipment_stat()
	print(weapon_damage)

func _input(event):
	if event.is_action_pressed("TESTING_BUTTON"):
		get_equipment_stat()
