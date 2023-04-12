extends AnimatedSprite

var player

func _ready():
	player = get_tree().root.get_node("/root/OverWorld/YSort/Player")
	frames = player.sprite_player_fx

func _on_PlayerFX_animation_finished():
	queue_free()

func play_touch():
	if player.roll_vector == Vector2.RIGHT:
		play("Touch_Right")
	if player.roll_vector == Vector2.DOWN:
		play("Touch_Down")
	if player.roll_vector == Vector2.UP:
		play("Touch_Up")
	if player.roll_vector == Vector2.LEFT:
		play("Touch_Left")

func play_aoe():
	if player.roll_vector == Vector2.RIGHT:
		play("AoE_Right")
	if player.roll_vector == Vector2.DOWN:
		play("AoE_Down")
	if player.roll_vector == Vector2.UP:
		play("AoE_Up")
	if player.roll_vector == Vector2.LEFT:
		play("AoE_Left")

func play_self():
	if player.roll_vector == Vector2.RIGHT:
		play("Self_Right")
	if player.roll_vector == Vector2.DOWN:
		play("Self_Down")
	if player.roll_vector == Vector2.UP:
		play("Self_Up")
	if player.roll_vector == Vector2.LEFT:
		play("Self_Left")
