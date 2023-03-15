extends ColorRect

class_name Split_Stack

signal stackSplit

onready var qty_slider = $"main panel/scale/quantity_slider"
onready var label_original = $"main panel/scale/original_qty"
onready var label_new = $"main panel/scale/new_qty"

var quantity
var new_quantity
var inventory_slot

func display(slot):
	quantity = slot.item.quantity
	inventory_slot = slot
	qty_slider.max_value = quantity - 1
	qty_slider.min_value = 1
	qty_slider.step = 1
	qty_slider.value = int(round(quantity / 2))
	set_labels()
	show()

func set_labels():
	label_original.text = str(qty_slider.value)
	new_quantity = quantity - qty_slider.value
	label_new.text = str(new_quantity)

func _on_CloseButton_pressed():
	hide()

func _on_quantity_slider_value_changed(value):
	set_labels()

func _on_SplitButton_pressed():
	emit_signal("stackSplit", inventory_slot, new_quantity)
	hide()
