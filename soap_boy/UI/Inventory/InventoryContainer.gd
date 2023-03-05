extends ColorRect

onready var xp_bar = $"../XP"
onready var health_bar = $"../Health"
onready var mana_bar = $"../Mana"
onready var stamina_bar = $"../Stamina"
onready var clock = $"../Clock"
onready var player = $"../../YSort/Player"

onready var statDisplay = $StatDisplay/PlayerStatLabel
onready var healthHover = $StatDisplay/HealthHover
onready var manaHover = $StatDisplay/ManaHover
onready var staminaHover = $StatDisplay/StaminaHover
onready var playerINVLevel = $StatDisplay/PlayerLevelLabel
onready var xpBar = $StatDisplay/XPBar
onready var xpProgress = $StatDisplay/PlayerXPLabel

var healthHoverTex = preload("res://UI/Inventory/inv_stat_bars/inv_health.png")
var manaHoverTex = preload("res://UI/Inventory/inv_stat_bars/inv_mana.png")
var staminaHoverTex = preload("res://UI/Inventory/inv_stat_bars/inv_stamina.png")

var inv_can_open = true
var is_inventory_open = false
var inventory = preload("res://UI/Inventory/Inventory.tres")

func _ready():
	$NameLabel.text = str(GameState.player_name)
	statDisplay.visible = false
	xpProgress.visible = false

func _unhandled_input(event):
	if event.is_action_pressed("inventory") and inv_can_open == true:
		if is_inventory_open == true:
			close_inventory()
			show_player_ui()
		else:
			open_inventory()
			hide_player_ui()

#Open and Close Inventory
func close_inventory():
	get_tree().paused = false
	visible = false
	is_inventory_open = false
	statDisplay.visible = false
	xpProgress.visible = false

func open_inventory():
	get_tree().paused = true
	visible = true
	is_inventory_open = true
	set_xp_bar()

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

#Stat Display | Health
func _on_HealthHover_mouse_entered():
	statDisplay.visible = true
	statDisplay.text = str(floor(player.health)) + "/" + str(player.max_health)
	healthHover.texture = healthHoverTex

func _on_HealthHover_mouse_exited():
	statDisplay.visible = false
	healthHover.texture = null

#Stat Display | Mana
func _on_ManaHover_mouse_entered():
	statDisplay.visible = true
	statDisplay.text = str(floor(player.mana)) + "/" + str(player.max_mana)
	manaHover.texture = manaHoverTex

func _on_ManaHover_mouse_exited():
	statDisplay.visible = false
	manaHover.texture = null

#Stat Display | Stamina
func _on_StaminaHover_mouse_entered():
	statDisplay.visible = true
	statDisplay.text = str(floor(player.stamina)) + "/" + str(player.max_stamina)
	staminaHover.texture = staminaHoverTex

func _on_StaminaHover_mouse_exited():
	statDisplay.visible = false
	staminaHover.texture = null

#XP Bar & Level
func set_xp_bar():
	xpBar.max_value = player.xp_next_level
	xpBar.value = player.xp
	playerINVLevel.text = str(player.level)
	xpProgress.text = str(player.xp) + "/" + str(player.xp_next_level)

func _on_XPBar_mouse_entered():
	xpProgress.visible = true

func _on_XPBar_mouse_exited():
	xpProgress.visible = false
