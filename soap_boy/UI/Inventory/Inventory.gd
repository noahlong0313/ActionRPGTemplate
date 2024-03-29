extends NinePatchRect

class_name Inventory

var inventory_slot_res = preload("res://UI/Inventory/inventory_slot.tscn")

export(String) var inventory_name
export(int) var size = 0 setget set_inventory_size

export(NodePath) onready var title = get_node(title) as Label
export(NodePath) onready var slot_cont = get_node(slot_cont) as Control

var slots : Array = []
var is_open

func _ready():
	for s in slots:
		slot_cont.add_child(s)
	
	set_title()
	InvSignalManager.emit_signal("inventory_ready", self)

func set_title():
	title.text = "-" + inventory_name + "-"

func set_inventory_size(value):
	size = value
	rect_min_size.y = 40 + (ceil(size / 5.0) - 1) * 22
	
	for s in size:
		var new_slot =inventory_slot_res.instance()
		slots.append(new_slot)

func add_item( item ):
	for s in slots:
		if s.try_put_item( item ):
			item = s.put_item( item )
			
			if not item:
				return null
	return item

