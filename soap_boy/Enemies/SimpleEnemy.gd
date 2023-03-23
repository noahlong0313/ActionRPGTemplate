extends KinematicBody2D

export (Resource) var stats

const knockbackAmount = 120
var SimpleEnemyDeathEffect = preload("res://Effects/DeathEffects/SimpleEnemyDeathEffect.tscn")

export var MAX_SPEED = 50
export var ACCELERATION = 300
export var FRICTION = 200

enum {
	IDLE,
	WANDER,
	CHASE
}

#Stats Variables
var health
var gained_xp
var speed

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO
var player
# Default State
var state = CHASE

onready var sprite = $AnimatedSprite
onready var playerDetectionZone = $PlayerDetectionZone

func _ready():
	health = stats.health
	gained_xp = stats.gained_xp
	sprite.frames = stats.sprite
	
	player = get_tree().root.get_node("/root/OverWorld/YSort/Player")

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)
	# State Machine
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
		
		WANDER:
			pass
		
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				var direction = global_position.direction_to(player.global_position)
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			else:
				state = IDLE
			sprite.flip_h = velocity.x < 0

	velocity = move_and_slide(velocity)

func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE

func _on_Hurtbox_area_entered(area):
	knockback = area.knockback_vector * knockbackAmount
	self.health -= player.player_damage
	if health <= 0:
		death()

func death():
	queue_free()
	player.add_xp(gained_xp)
	# Death Effect
	var simpleEnemydeatheffect = SimpleEnemyDeathEffect.instance()
	get_parent().add_child(simpleEnemydeatheffect)
	simpleEnemydeatheffect.global_position = global_position
