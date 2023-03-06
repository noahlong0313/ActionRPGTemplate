extends Node

export(NodePath) onready var item_In_Hand_node = get_node(item_In_Hand_node) as Control
export(NodePath) onready var item_info = get_node(item_info) as Control

var inventories : Array = []
var item_In_Hand = null
var item_offset = Vector2.ZERO

func _ready():
	InvSignalManager.connect("inventory_ready", self, "_on_inventory_ready")

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
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if item_In_Hand:
			item_In_Hand_node.remove_child(item_In_Hand)
			
			if slot.item:
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
			item_In_Hand_node.rect_global_position - event.global_position - item_offset
