extends Popup

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
	player.max_health += 2
	player.health += 5
	player.emit_signal("player_stats_changed", player)
	hide()
	set_process_input(false)
	get_tree().paused = false
	print(player.max_health)

func _on_ManaButton_pressed():
	player.max_mana += 2
	player.mana += 5
	player.emit_signal("player_stats_changed", player)
	hide()
	set_process_input(false)
	get_tree().paused = false
	print(player.max_mana)

func _on_StaminaButton_pressed():
	player.max_stamina += 2
	player.stamina += 5
	player.emit_signal("player_stats_changed", player)
	hide()
	set_process_input(false)
	get_tree().paused = false
	print(player.max_stamina)
