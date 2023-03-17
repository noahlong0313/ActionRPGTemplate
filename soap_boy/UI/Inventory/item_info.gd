extends NinePatchRect

class_name Item_Info

export(NodePath) onready var item_name = get_node(item_name) as Label

onready var item_description_cont = $item_info_container
onready var item_description = $item_info_container/item_desc_Label

func display(slot : Inventory_Slot):
	rect_global_position = slot.rect_size + slot.rect_global_position
	item_name.text = slot.item.item_name
	item_description.text = slot.item.item_desc
	show()
	yield(get_tree(), "idle_frame")
	rect_size.y = item_description_cont.rect_size.y + 9
