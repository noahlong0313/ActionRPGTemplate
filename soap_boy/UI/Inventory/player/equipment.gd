extends Inventory

export(NodePath) onready var accessory = get_node(accessory) as Inventory_Slot
export(NodePath) onready var weapon = get_node(weapon) as Inventory_Slot
export(NodePath) onready var magic_1 = get_node(magic_1) as Inventory_Slot
export(NodePath) onready var magic_2 = get_node(magic_2) as Inventory_Slot

func _ready():
	slots.append(accessory)
	slots.append(weapon)
	slots.append(magic_1)
	slots.append(magic_2)
	InvSignalManager.emit_signal("inventory_ready", self)

func set_inventory_size(value):
	size = value
