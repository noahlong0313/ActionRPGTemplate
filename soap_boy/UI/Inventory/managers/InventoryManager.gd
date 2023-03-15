extends Node

export(NodePath) onready var item_In_Hand_node = get_node(item_In_Hand_node) as Control
export(NodePath) onready var item_info = get_node(item_info) as Control
export(NodePath) onready var split_stack = get_node(split_stack) as Split_Stack

var inventories : Array = []
var item_In_Hand = null
var item_offset = Vector2.ZERO 

func _ready():
	InvSignalManager.connect("inventory_ready", self, "_on_inventory_ready")
	split_stack.connect("stackSplit", self, "_on_stackSplit")

func _on_inventory_ready(inventory):
	inventories.append(inventory)
	
	for slot in inventory.slots:
		slot.connect("mouse_entered", self, "_on_mouse_entered_slot", [slot])
		slot.connect("mouse_exited", self, "_on_mouse_exited_slot")
		slot.connect("gui_input", self, "_on_gui_input_slot", [slot])

func _input(event : InputEvent):
	if event is InputEventMouseMotion and item_In_Hand:
		item_In_Hand.rect_position = event.position - item_offset

func _on_mouse_entered_slot(slot):
	if slot.item:
		item_info.display(slot)

func _on_mouse_exited_slot():
	item_info.hide()

func _on_gui_input_slot(event : InputEvent, slot : Inventory_Slot):
	if slot.item and slot.item.quantity > 1 and item_In_Hand == null and event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_RIGHT and  Input.is_key_pressed(KEY_SHIFT):
		split_stack.display(slot)
	elif event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if item_In_Hand:
			if slot is Equipment_Slot and item_In_Hand.equipment_type != slot.type:
				return
			
			item_In_Hand_node.remove_child(item_In_Hand)
			
			if slot.item:
				if slot.item.id == item_In_Hand.id and slot.item.quantity < slot.item.stack_size:
					var remainder = slot.item.add_item_quantity(item_In_Hand.quantity)
					
					if remainder < 1:
						item_In_Hand = null
					else:
						item_In_Hand_node.add_child(item_In_Hand)
						item_In_Hand.quantity = remainder
				else:
					var temp_item = slot.item
					slot.pick_item()
					temp_item.rect_global_position = event.global_position - item_offset
					slot.put_item(item_In_Hand)
					item_In_Hand = temp_item
					item_In_Hand_node.add_child(item_In_Hand)
			else:
				slot.put_item(item_In_Hand)
				item_In_Hand = null
			
		elif slot.item:
			item_In_Hand = slot.item
			item_offset = event.global_position - item_In_Hand.rect_global_position
			slot.pick_item()
			item_In_Hand_node.add_child(item_In_Hand)
			item_In_Hand.rect_global_position = event.global_position - item_offset

func _on_stackSplit(slot, new_quantity):
	slot.item.quantity -= new_quantity
	var new_item = ItemManager.get_item(slot.item.id)
	new_item.quantity = new_quantity
	item_In_Hand = new_item
	item_In_Hand_node.add_child(item_In_Hand)
