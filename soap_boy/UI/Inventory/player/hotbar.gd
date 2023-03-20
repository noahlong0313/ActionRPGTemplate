extends NinePatchRect

class_name Hotbar

export (NodePath) onready var slot_container = get_node(slot_container) as Control

export (int) var size

var slots : Array = []

func _ready():
	for s in size:
		var slot = ItemManager.tscn.hotbar_slot.instance()
		slot.key = str(s + 1)
		slot_container.add_child(slot)
		slots.append(slot)
	InvSignalManager.emit_signal("inventory_ready", self)
