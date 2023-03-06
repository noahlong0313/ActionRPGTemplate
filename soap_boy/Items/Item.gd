extends TextureRect

class_name Item

export(String) var id
export(String) var item_name

var picked = false

func pick_item():
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	picked = true

func put_item():
	mouse_filter = Control.MOUSE_FILTER_PASS
	picked = false
