extends ColorRect

onready var xp_bar = $"../XP"
onready var health_bar = $"../Health"
onready var mana_bar = $"../Mana"
onready var stamina_bar = $"../Stamina"
onready var clock = $"../Clock"

var is_inventory_open = false
var inventory = preload("res://UI/Inventory/Inventory.tres")

func _ready():
	$NameLabel.text = str(GameState.player_name)

func _unhandled_input(event):
	if event.is_action_pressed("inventory"):
		if is_inventory_open == true:
			close_inventory()
			show_player_ui()
		else:
			open_inventory()
			hide_player_ui()

func close_inventory():
	get_tree().paused = false
	visible = false
	is_inventory_open = false

func open_inventory():
	get_tree().paused = true
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
