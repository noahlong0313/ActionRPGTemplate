extends NinePatchRect

export(NodePath) onready var inventory = get_node(inventory) as Inventory

var inv_can_open = true
var is_inventory_open = false

onready var xp_bar = $"../XP"
onready var health_bar = $"../Health"
onready var mana_bar = $"../Mana"
onready var stamina_bar = $"../Stamina"
onready var clock = $"../Clock"
onready var player = $"../../YSort/Player"

func _ready():
	$title/Label.text = str(GameState.player_name)
	rect_size.y = 20 + inventory.rect_size.y

#Open and Close Inventory
func _unhandled_input(event):
	if event.is_action_pressed("inventory") and inv_can_open == true:
		if is_inventory_open == true:
			close_inventory()
			show_player_ui()
		else:
			hide_player_ui()
			open_inventory()

func close_inventory():
	visible = false
	is_inventory_open = false

func open_inventory():
	visible = true
	is_inventory_open = true

func hide_player_ui():
	xp_bar.visible = false
	health_bar.visible = false
	mana_bar.visible = false
	stamina_bar.visible = false
	clock.visible = false

func show_player_ui():
	xp_bar.visible = true
	health_bar.visible = true
	mana_bar.visible = true
	stamina_bar.visible = true
	clock.visible = true
