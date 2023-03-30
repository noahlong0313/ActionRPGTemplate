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

var stats : Resource

enum {
	MOVE,
	ROLL,
	ATTACK,
	MAGIC1,
	MAGIC2,
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
var health_lvl_mod = 0
var mana_lvl_mod = 0
var stamina_lvl_mod = 0
#Equipment
var equipment

var player_damage
var stamina_drain = 0
var mana_drain = 0 

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitbox = $HitboxPivot/SwordHitbox

#Object Interaction
onready var interactArea = $InteractArea
onready var interactLabels = $Interact_Labels

var current_interactable

#Ready on Start
func _ready():
	stats = GameState.player_race
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
	#Inventory
	InvSignalManager.connect("item_dropped", self, "_on_item_dropped")
	InvSignalManager.connect("level_up", self, "_on_level_up")
	#Misc
	emit_signal("player_stats_changed", self)
	animationTree.active = true
	swordHitbox.knockback_vector = roll_vector
	equipment = get_node("/root/OverWorld/CanvasLayer/inventory_player/inventory_cont/equipment")

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
		
		MAGIC1:
			magic1_state(delta)
		
		MAGIC2:
			magic2_state(delta)
		
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
	
	if not current_interactable:
		var overlapping_area = interactArea.get_overlapping_areas()
		
		if overlapping_area.size() > 0 and overlapping_area[ 0 ].has_method("interact"):
			current_interactable = overlapping_area[ 0 ]
			interactLabels.display(current_interactable)
	
	#Equipment
	equipment.get_weapon_stat()
	equipment.get_accessory_stat()
	equipment.get_magic1_stat()
	equipment.get_magic2_stat()
	equipment.get_equipment_stat()
	
	set_reg_stats()
	set_max_stats()

func _input(event):
	if event.is_action_pressed("interact") and current_interactable:
		current_interactable.interact()

func _on_InteractArea_area_exited(area):
	if current_interactable == area:
		if current_interactable.has_method("out_of_range"):
			current_interactable.out_of_range()
		
		current_interactable = null
		interactLabels.hide()

func _on_item_dropped( item ):
	var floor_item = ItemManager.tscn.floor_item.instance()
	floor_item.item = item
	get_parent().add_child( floor_item )
	floor_item.position = position

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
		animationTree.set("parameters/Magic/blend_position", input_vector)
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
	
	if Input.is_action_just_pressed("spell_slot_1"):
		if equipment.magic1_damage != 0:
			state = MAGIC1
			magic1_mana_drain()
		else:
			state = MOVE
	
	if Input.is_action_just_pressed("spell_slot_2"):
		if equipment.magic2_damage != 0:
			state = MAGIC2
			magic2_mana_drain()
		else:
			state = MOVE

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
	player_damage = equipment.weapon_damage
	velocity = Vector2.ZERO
	animationState.travel("Attack")
func attack_animation_finished():
	state = MOVE
## Magic
func magic1_state(delta):
	player_damage = equipment.magic1_damage
	velocity = velocity / CAST_SPEED
	animationState.travel("Magic")
	
func magic2_state(delta):
	player_damage = equipment.magic2_damage
	velocity = velocity / CAST_SPEED
	animationState.travel("Magic")
	
func magic_animation_finished():
	state = MOVE
## Move
func move():
	velocity = move_and_slide(velocity)

#Stat Functions
func set_max_stats():
	max_health = stats.max_health + equipment.equipment_max_health + health_lvl_mod
	max_mana = stats.max_mana + equipment.equipment_max_mana + mana_lvl_mod
	max_stamina = stats.max_stamina + equipment.equipment_max_stamina + stamina_lvl_mod

func set_reg_stats():
	health_reg = stats.health_reg + equipment.equipment_regeneration_health
	mana_reg = stats.mana_reg + equipment.equipment_regeneration_mana
	stamina_reg = stats.stamina_reg + equipment.equipment_regeneration_stamina
	
	if health_reg <= 0:
		health_reg = 0
	if mana_reg <= 0:
		mana_reg = 0
	if stamina_reg <= 0:
		stamina_reg = 0

func _on_level_up():
	health = max_health
	mana = max_mana
	stamina = max_stamina

## Health
func _on_Hurtbox_area_entered(area):
	knockback = area.global_position.direction_to(global_position) * knockbackAmount
	self.health -= 1
	if health <= 0:
		queue_free()
## Stamina
func stamina_drain_attack():
	stamina_drain = equipment.equipment_drain_stamina
	if stamina >= 1:
		self.stamina -= stamina_drain
		emit_signal("player_stats_changed", self)
	else:
			state = MOVE
	if stamina <= 0:
		self.stamina = 0

func stamina_drain_roll():
	if stamina >= 2:
		self.stamina -= 2
		emit_signal("player_stats_changed", self)
	else:
			state = MOVE
	if stamina <= 0:
		self.stamina = 0
## Magic
func magic1_mana_drain():
	mana_drain = equipment.magic1_drain
	if mana >= 1:
		self.mana -= mana_drain
		emit_signal("player_stats_changed", self)
	else:
			state = MOVE
	if mana <= 0:
		self.mana = 0

func magic2_mana_drain():
	mana_drain = equipment.magic2_drain
	if mana >= 1:
		self.mana -= mana_drain
		emit_signal("player_stats_changed", self)
	else:
			state = MOVE
	if mana <= 0:
		self.mana = 0
## Level System
func add_xp(value):
	xp += value
	if xp >= xp_next_level:
		level += 1
		xp_next_level *= 2
		emit_signal("player_level_up")
	emit_signal("player_stats_changed", self)
