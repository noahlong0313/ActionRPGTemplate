extends NinePatchRect

export(NodePath) onready var inventory = get_node(inventory) as Inventory
export(NodePath) onready var equipment = get_node(equipment) as Inventory

onready var inventoryContainer = $"../inventory_cont"
onready var itemInfo = $"../item_info"

var inv_can_open = true
var is_inventory_open = false

onready var xp_bar = $"../XP"
onready var health_bar = $"../Health"
onready var mana_bar = $"../Mana"
onready var stamina_bar = $"../Stamina"
onready var clock = $"../Clock"
onready var player = $"../../YSort/Player"

onready var statDisplay = $StatDisplay/PlayerStatLabel
onready var healthBar = $StatDisplay/HealthBar
onready var manaBar = $StatDisplay/ManaBar
onready var staminaBar = $StatDisplay/StaminaBar
onready var playerINVLevel = $StatDisplay/PlayerLevelLabel
onready var xpBar = $StatDisplay/XPBar
onready var xpProgress = $StatDisplay/PlayerXPLabel

func _ready():
	var inventories = [equipment, inventory]
	InvSignalManager.emit_signal("player_inventory_ready", inventories)
	$title/Label.text = str(GameState.player_name)
	rect_size.y = 155
	xpProgress.visible = false
	set_inv_stats()

#Open and Close Inventory
func _unhandled_input(event):
	if event.is_action_pressed("inventory") and inv_can_open == true:
		if is_inventory_open == true:
			close_inventory()
			show_player_ui()
			xpProgress.visible = false
		else:
			hide_player_ui()
			open_inventory()
			set_inv_stats()
		if inventoryContainer.container_open == true:
			inventoryContainer.close()

func close_inventory():
	visible = false
	statDisplay.visible = false
	is_inventory_open = false
	player.state = player.MOVE
	itemInfo.visible = false

func open_inventory():
	visible = true
	is_inventory_open = true
	player.state = player.IDLE

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

#Inventory Stats
func set_inv_stats():
	set_health_bar()
	set_mana_bar()
	set_stamina_bar()
	set_xp_bar()

func set_health_bar():
	healthBar.max_value = player.max_health
	healthBar.value = player.health

func set_mana_bar():
	manaBar.max_value = player.max_mana
	manaBar.value = player.mana

func set_stamina_bar():
	staminaBar.max_value = player.max_stamina
	staminaBar.value = player.stamina

##Stats Hover
func _on_HealthBar_mouse_entered():
	statDisplay.visible = true
	statDisplay.text = str(floor(player.health)) + "/" + str(player.max_health)

func _on_HealthBar_mouse_exited():
	statDisplay.visible = false

func _on_ManaBar_mouse_entered():
	statDisplay.visible = true
	statDisplay.text = str(floor(player.mana)) + "/" + str(player.max_mana)

func _on_ManaBar_mouse_exited():
	statDisplay.visible = false

func _on_StaminaBar_mouse_entered():
	statDisplay.visible = true
	statDisplay.text = str(floor(player.stamina)) + "/" + str(player.max_stamina)

func _on_StaminaBar_mouse_exited():
	statDisplay.visible = false

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

