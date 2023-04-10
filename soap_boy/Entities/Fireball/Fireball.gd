extends Area2D

var speed = 80
var direction : Vector2
var knockback_vector : Vector2

onready var sprite = $AnimatedSprite

func _ready():
	sprite.play("fly")

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
