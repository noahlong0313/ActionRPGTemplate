extends Area2D

var speed = 0
var direction : Vector2
var knockback_vector : Vector2

var player

onready var sprite = $AnimatedSprite

func _ready():
	player = get_tree().root.get_node("/root/OverWorld/YSort/Player")
	sprite.frames = player.sprite_ranged
	sprite.play("fly")
	if player.roll_vector == Vector2.RIGHT:
		rotation_degrees = 0
	if player.roll_vector == Vector2.DOWN:
		rotation_degrees = 90
	if player.roll_vector == Vector2.UP:
		rotation_degrees = 270
	if player.roll_vector == Vector2.LEFT:
		rotation_degrees = 180

func _process(delta):
	position = position + speed * delta * direction
	knockback_vector = direction

func _on_Fireball_area_entered(area):
	explode()

func explode():
	direction = Vector2.ZERO
	sprite.play("explode")
	call_deferred("set", "monitorable", false)

func _on_AnimatedSprite_animation_finished():
	if sprite.animation == "explode":
		queue_free()
