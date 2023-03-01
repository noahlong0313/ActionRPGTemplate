extends KinematicBody2D

var knockbackAmount = knockbackAmount
var MAX_SPEED = move_speed
var ROLL_SPEED = roll_speed
var CAST_SPEED = cast_speed
export var ACCELERATION = 400
export var ROLL_END_SPEED = 2
export var FRICTION = 450

signal player_stats_changed
signal player_level_up

#Get Resource from race for stats
export (Resource) var stats

enum {
	MOVE,
	ROLL,
	ATTACK,
	MAGIC,
	IDLE
}
#Movement Variables
var state = MOVE
var velocity = Vector2.ZERO
var roll_vector = Vector2.DOWN
var knockback = Vector2.ZERO
#Race Variables
var max_health
var max_mana
var max_stamina
var move_speed
var roll_speed
var cast_speed
var health_reg
var mana_reg
var stamina_reg
var health
var mana
var stamina
#Level System
var xp = 0
var xp_next_level = 100;
var level = 1;

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitbox = $HitboxPivot/SwordHitbox

#Ready on Start
func _ready():
	#Race Stats Convert
	max_health = stats.max_health
	max_mana = stats.max_mana
	max_stamina = stats.max_stamina
	MAX_SPEED = stats.move_speed
	ROLL_SPEED = stats.roll_speed
	CAST_SPEED = stats.cast_speed
	knockbackAmount = stats.knockback_amt
	health_reg = stats.health_reg
	mana_reg = stats.mana_reg
	stamina_reg = stats.stamina_reg
	health = stats.max_health
	mana = stats.max_mana
	stamina = stats.max_stamina
	#Misc
	emit_signal("player_stats_changed", self)
	animationTree.active = true
	swordHitbox.knockback_vector = roll_vector

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)
	#State Machine
	match state:
		MOVE:
			move_state(delta)
		
		ROLL:
			roll_state(delta)
		
		ATTACK:
			attack_state(delta)
		
		MAGIC:
			magic_state(delta)
		
		IDLE:
			pass

func _process(delta):
	#Mana Regeneration
	var new_mana = min(mana + mana_reg * delta, max_mana)
	if new_mana != mana:
		mana = new_mana
		emit_signal("player_stats_changed", self)
	#Health Regeneration
	var new_health = min(health + health_reg * delta, max_health)
	if new_health != health:
		health = new_health
		emit_signal("player_stats_changed", self)
	#Stamina Regeneration
	var new_stamina = min(stamina + stamina_reg * delta, max_stamina)
	if new_stamina != stamina:
		stamina = new_stamina
		emit_signal("player_stats_changed", self)

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()
## Animation Switiching | Blend Positions for Animation States
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		swordHitbox.knockback_vector = input_vector
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationTree.set("parameters/Roll/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move()
	if Input.is_action_just_pressed("Roll"):
		state = ROLL
		stamina_drain_roll()
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
		stamina_drain_attack()
	
	if Input.is_action_just_pressed("spell_cast"):
		state = MAGIC
		mana_drain()
	

#State Functions
## Roll
func roll_state(delta):
	velocity = roll_vector * ROLL_SPEED
	animationState.travel("Roll")
	move()

func roll_animation_finished():
	velocity = velocity / ROLL_END_SPEED
	state = MOVE

# Attack
func attack_state(delta):
	velocity = Vector2.ZERO
	animationState.travel("Attack")

func attack_animation_finished():
	state = MOVE

## Magic
func magic_state(delta):
	velocity = velocity / CAST_SPEED
	animationState.travel("Attack")

func magic_animation_finished():
	state = MOVE

## Move
func move():
	velocity = move_and_slide(velocity)

#Stat Functions
## Health
func _on_Hurtbox_area_entered(area):
	knockback = area.global_position.direction_to(global_position) * knockbackAmount
	self.health -= 1
	if health <= 0:
		queue_free()

## Stamina
func stamina_drain_attack():
	if stamina >= 1:
		self.stamina -= 1
		emit_signal("player_stats_changed", self)
	else:
			state = MOVE

func stamina_drain_roll():
	if stamina >= 2:
		self.stamina -= 2
		emit_signal("player_stats_changed", self)
	else:
			state = MOVE

## Magic
func mana_drain():
	if mana >= 1:
		self.mana -= 1
		emit_signal("player_stats_changed", self)
	else:
			state = MOVE

## Level System
func add_xp(value):
	xp += value
	if xp >= xp_next_level:
		level += 1
		xp_next_level *= 2
		emit_signal("player_level_up")
	emit_signal("player_stats_changed", self)
