extends TextureRect

class_name Item

var id
var item_name
var equipment_type = GameEnums.EQUIPMENT_TYPE.NONE
var stack_size = 1
var quantity = 1
var level = 1
var components = {}

func _init(item_id, data):
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	id = item_id
	item_name = data.name
	level = data.level
