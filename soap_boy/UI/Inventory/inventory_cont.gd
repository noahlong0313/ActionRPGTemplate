extends NinePatchRect

export(NodePath) onready var inv_cont = get_node(inv_cont) as Control

var current_inventories : Array = []
var container_open = false

onready var player = $"../../YSort/Player"
onready var inventoryPlayer = $"../inventory_player"
onready var itemInfo = $"../item_info"

func _ready():
	InvSignalManager.connect("inventory_opened", self, "_on_inventory_opened")
	InvSignalManager.connect("inventory_closed", self, "_on_inventory_closed")

func close():
	for i in current_inventories:
		inv_cont.remove_child(i)
		i.is_open = false
	
	current_inventories = []
	hide()
	container_open = false
	itemInfo.visible = false

func _on_inventory_opened(inventory : Inventory):
	inventory.is_open = true
	if current_inventories.size() == 0:
		rect_size.y = 19
	
	if current_inventories.has(inventory):
		return
	
	inv_cont.add_child(inventory)
	current_inventories.append(inventory)
	rect_size.y += inventory.rect_size.y + inv_cont.get_constant("separation")
	show()
	container_open = true
	player.state = player.IDLE
	inventoryPlayer.open_inventory()
	inventoryPlayer.hide_player_ui()


func _on_inventory_closed(inventory : Inventory):
	inventory.is_open = false
	inv_cont = remove_child(inventory)
	current_inventories.remove(current_inventories.find(inventory))
	rect_size.y -= inventory.rect_size.y + inv_cont.get_constant("seperation")
	
	if current_inventories.size() == 0:
		hide()

func _on_TextureButton_pressed():
	close()
	if inventoryPlayer.is_inventory_open == false:
		player.state = player.MOVE
