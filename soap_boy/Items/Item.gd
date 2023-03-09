extends TextureRect

class_name Item

export(String) var id
export(String) var item_name
export(GameEnums.EQUIPMENT_TYPE) var equipment_type

func _ready():
	mouse_filter = Control.MOUSE_FILTER_IGNORE
