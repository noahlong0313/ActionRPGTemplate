extends NinePatchRect

export(NodePath) onready var inv_cont = get_node(inv_cont) as Control

var current_inventories : Array = []

onready var player = $"../../YSort/Player"

func _ready():
	InvSignalManager.connect("inventory_opened", self, "_on_inventory_opened")

func _on_inventory_opened(inventory : Inventory):
	if current_inventories.size() == 0:
		rect_size.y = 19
	
	if current_inventories.has(inventory):
		return
	
	inv_cont.add_child(inventory)
	current_inventories.append(inventory)
	rect_size.y += inventory.rect_size.y + inv_cont.get_constant("separation")
	show()
	player.state = player.IDLE

func close():
	for i in current_inventories:
		inv_cont.remove_child(i)
	
	current_inventories = []
	hide()
	player.state = player.MOVE

func _on_TextureButton_pressed():
	close()
