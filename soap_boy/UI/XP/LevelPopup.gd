extends Popup

signal level_up

var player

func _ready():
	player = get_tree().root.get_node("/root/OverWorld/YSort/Player")
	set_process_input(false)
	$LevelUpContainer/HealthButton.grab_focus()

func _on_Player_player_level_up():
	set_process_input(true)
	popup_centered()
	get_tree().paused = true
	print(player.max_health, player.max_mana, player.max_stamina)

func _on_HealthButton_pressed():
	player.health_lvl_mod += 2
	player.emit_signal("player_stats_changed", player)
	hide()
	set_process_input(false)
	get_tree().paused = false
	InvSignalManager.emit_signal("level_up")

func _on_ManaButton_pressed():
	player.mana_lvl_mod += 2
	player.emit_signal("player_stats_changed", player)
	hide()
	set_process_input(false)
	get_tree().paused = false
	InvSignalManager.emit_signal("level_up")

func _on_StaminaButton_pressed():
	player.stamina_lvl_mod += 2
	player.emit_signal("player_stats_changed", player)
	hide()
	set_process_input(false)
	get_tree().paused = false
	InvSignalManager.emit_signal("level_up")
