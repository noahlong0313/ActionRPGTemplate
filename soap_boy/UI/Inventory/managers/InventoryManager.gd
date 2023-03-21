extends Node

export(NodePath) onready var item_In_Hand_node = get_node(item_In_Hand_node) as Control
export(NodePath) onready var item_info = get_node(item_info) as Control
export(NodePath) onready var split_stack = get_node(split_stack) as Split_Stack

onready var itemVoid = $"../CanvasLayer/Item_void"

var player_inventories : Array = []
var inventories : Array = []
var item_In_Hand : Item = null
var item_offset = Vector2.ZERO 

func _ready():
	InvSignalManager.connect( "item_picked", self, "_on_item_picked" )
	InvSignalManager.connect("inventory_ready", self, "_on_inventory_ready")
	InvSignalManager.connect("player_inventory_ready", self, "_on_player_inventory_ready")
	split_stack.connect("stackSplit", self, "_on_stackSplit")
	itemVoid.connect("gui_input", self, "_on_void_gui_input")

func _on_inventory_ready(inventory):
	inventories.append(inventory)
	
	for slot in inventory.slots:
		slot.connect("mouse_entered", self, "_on_mouse_entered_slot", [slot])
		slot.connect("mouse_exited", self, "_on_mouse_exited_slot")
		slot.connect("gui_input", self, "_on_gui_input_slot", [slot])

func _input(event : InputEvent):
	if event is InputEventMouseMotion and item_In_Hand:
		item_In_Hand.rect_position = (event.position - item_offset)

func _on_void_gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		InvSignalManager.emit_signal("item_dropped", item_In_Hand)
		
		item_In_Hand_node.remove_child(item_In_Hand)
		item_In_Hand = null
		set_item_void_filter()

func _on_mouse_entered_slot(slot):
	if is_instance_valid(slot.item):
		item_info.display(slot)

func _on_mouse_exited_slot():
	item_info.hide()

func _on_gui_input_slot(event : InputEvent, slot : Inventory_Slot):
	if is_instance_valid(slot.item) and slot.item.quantity > 1 and item_In_Hand == null and event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_RIGHT and  Input.is_key_pressed(KEY_SHIFT):
		if slot.item.quantity == 2:
			_on_stackSplit(slot , 1)
		else:
			split_stack.display(slot)
	elif event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		var had_empty_Hand = item_In_Hand == null
		
		if item_In_Hand:
			item_In_Hand_node.remove_child(item_In_Hand)
		
		item_In_Hand = slot.put_item(item_In_Hand)
		
		if item_In_Hand:
			if had_empty_Hand:
				item_offset = event.global_position - slot.rect_global_position
			
			item_In_Hand_node.add_child(item_In_Hand)
		
		set_hand_position(event.global_position)

func set_hand_position(pos):
	set_item_void_filter()
	
	if item_In_Hand:
		item_In_Hand.rect_position = (pos - item_offset)

func set_item_void_filter():
	itemVoid.mouse_filter = Control.MOUSE_FILTER_STOP if item_In_Hand else Control.MOUSE_FILTER_IGNORE

func _on_stackSplit(slot, new_quantity):
	slot.item.quantity -= new_quantity
	var new_item = ItemManager.get_item(slot.item.id)
	new_item.quantity = new_quantity
	item_In_Hand = new_item
	item_In_Hand_node.add_child(item_In_Hand)
	set_hand_position(slot.rect_global_position)

func _on_item_picked( item, sender ):
	for i in player_inventories:
		item = i.add_item( item )
		
		if not item:
			sender.item_picked()
			return

func _on_player_inventory_ready(inv):
	player_inventories = inv
