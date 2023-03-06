extends TextureRect

class_name Inventory_Slot

export(NodePath) onready var item_cont = get_node(item_cont) as Control

var item : Item

func _ready():
	if item:
		item_cont.add_child(item)

func set_item(new_item):
	item = new_item

func pick_item():
	item.pick_item()
	item_cont.remove_child(item)
	item = null

func put_item(new_item):
	item = new_item
	item.put_item()
	item_cont.add_child(item)
