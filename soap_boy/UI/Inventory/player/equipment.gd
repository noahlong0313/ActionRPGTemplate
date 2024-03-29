extends Inventory

export(NodePath) onready var accessory = get_node(accessory) as Inventory_Slot
export(NodePath) onready var weapon = get_node(weapon) as Inventory_Slot
export(NodePath) onready var magic_1 = get_node(magic_1) as Inventory_Slot
export(NodePath) onready var magic_2 = get_node(magic_2) as Inventory_Slot

#Damage
var weapon_damage = 0
var magic1_damage = 0
var magic2_damage = 0
#Added on ^
var accessory_damage = 0
#Drain
##Total from all equipment
var magic1_drain
var magic2_drain
var equipment_drain_stamina = 0
##Individual drain Values
var weapon_stamina_drain = 0
var weapon_mana_drain = 0
var accessory_stamina_drain = 0
var accessory_mana_drain = 0
var magic1_stamina_drain = 0
var magic1_mana_drain = 0
var magic2_stamina_drain = 0
var magic2_mana_drain = 0

#Regeneration
##Total from all equipment
var equipment_regeneration_health = 0
var equipment_regeneration_mana = 0
var equipment_regeneration_stamina = 0
##Individual Reg Values
var weapon_regeneration_health = 0
var weapon_regeneration_mana = 0
var weapon_regeneration_stamina = 0
var accessory_regeneration_health = 0
var accessory_regeneration_mana = 0
var accessory_regeneration_stamina = 0
var magic1_regeneration_health = 0
var magic1_regeneration_mana = 0
var magic1_regeneration_stamina = 0
var magic2_regeneration_health = 0
var magic2_regeneration_mana = 0
var magic2_regeneration_stamina = 0

#Movement
var weapon_speed = 0
var accessory_speed = 0
var magic1_speed = 0
var magic2_speed = 0

#Max Stat
##Total from all equipment
var equipment_max_health  = 0
var equipment_max_mana = 0
var equipment_max_stamina = 0
##Individual Max Values
var weapon_max_health = 0
var weapon_max_mana = 0
var weapon_max_stamina = 0
var accessory_max_health = 0
var accessory_max_mana = 0
var accessory_max_stamina = 0
var magic1_max_health = 0
var magic1_max_mana = 0
var magic1_max_stamina = 0
var magic2_max_health = 0
var magic2_max_mana = 0
var magic2_max_stamina = 0

# Spells
##Self Cast
var magic1_self_health = 0
var magic1_self_stamina = 0
var magic2_self_health = 0
var magic2_self_stamina = 0
var magic1_spellTime = 0.0
var magic2_spellTime = 0.0

var magic1_type = null
var magic2_type = null
var magic1_timed = false
var magic2_timed = false

var magic1_projectile_speed
var magic2_projectile_speed

var magic1_sprite_ranged
var magic2_sprite_ranged

var magic1_sprite_player_fx
var magic2_sprite_player_fx

var weapon_type = null
var weapon_sprite_ranged
var weapon_projectile_speed

var item : Item
var player

func _ready():
	slots.append(accessory)
	slots.append(weapon)
	slots.append(magic_1)
	slots.append(magic_2)
	player = get_tree().root.get_node("/root/OverWorld/YSort/Player")
	InvSignalManager.emit_signal("inventory_ready", self)

func set_inventory_size(value):
	size = value

func get_weapon_stat():
	if slots[1].item:
		weapon_damage = slots[1].item.damage
		weapon_stamina_drain = slots[1].item.stamina_drain
		weapon_mana_drain = slots[1].item.mana_drain
		weapon_regeneration_health = slots[1].item.reg_Health_Change
		weapon_regeneration_mana = slots[1].item.reg_Mana_Change
		weapon_regeneration_stamina = slots[1].item.reg_Stamina_Change
		weapon_speed = slots[1].item.player_Speed_Change
		weapon_max_health = slots[1].item.max_Health_Change
		weapon_max_mana = slots[1].item.max_Mana_Change
		weapon_max_stamina = slots[1].item.max_Stamina_Change
		weapon_type = slots[1].item.weapon_type
		weapon_sprite_ranged = slots[1].item.ranged_sprite
		weapon_projectile_speed = slots[1].item.projectile_speed
	
	else:
		weapon_damage = 0
		weapon_stamina_drain = 0
		weapon_mana_drain = 0
		weapon_regeneration_health = 0
		weapon_regeneration_mana = 0
		weapon_regeneration_stamina = 0
		weapon_speed = 0
		weapon_max_health = 0
		weapon_max_mana = 0
		weapon_max_stamina = 0
		weapon_type = null
		weapon_sprite_ranged = null
		weapon_projectile_speed = 0

func get_accessory_stat():
	if slots[0].item:
		accessory_damage = slots[0].item.damage
		accessory_stamina_drain = slots[0].item.stamina_drain
		accessory_mana_drain = slots[0].item.mana_drain
		accessory_regeneration_health = slots[0].item.reg_Health_Change
		accessory_regeneration_mana = slots[0].item.reg_Mana_Change
		accessory_regeneration_stamina = slots[0].item.reg_Stamina_Change
		accessory_speed = slots[0].item.player_Speed_Change
		accessory_max_health = slots[0].item.max_Health_Change
		accessory_max_mana = slots[0].item.max_Mana_Change
		accessory_max_stamina = slots[0].item.max_Stamina_Change
	
	else:
		accessory_damage = 0
		accessory_stamina_drain = 0
		accessory_mana_drain = 0
		accessory_regeneration_health = 0
		accessory_regeneration_mana = 0
		accessory_regeneration_stamina = 0
		accessory_speed = 0
		accessory_max_health = 0
		accessory_max_mana = 0
		accessory_max_stamina = 0

func get_magic1_stat():
	if slots[2].item:
		magic1_damage = slots[2].item.damage
		magic1_stamina_drain = slots[2].item.stamina_drain
		magic1_mana_drain = slots[2].item.mana_drain
		magic1_regeneration_health = slots[2].item.reg_Health_Change
		magic1_regeneration_mana = slots[2].item.reg_Mana_Change
		magic1_regeneration_stamina = slots[2].item.reg_Stamina_Change
		magic1_speed = slots[2].item.player_Speed_Change
		magic1_max_health = slots[2].item.max_Health_Change
		magic1_max_mana = slots[2].item.max_Mana_Change
		magic1_max_stamina = slots[2].item.max_Stamina_Change
		magic1_type = slots[2].item.magic_type
		magic1_self_health = slots[2].item.self_heal
		magic1_self_stamina = slots[2].item.self_stamina
		magic1_spellTime = slots[2].item.time
		magic1_timed = slots[2].item.TIMED_SPELL
		magic1_sprite_ranged = slots[2].item.ranged_sprite
		magic1_sprite_player_fx = slots[2].item.player_FX_sprite
		magic1_projectile_speed = slots[2].item.projectile_speed
	
	else:
		magic1_type = null
		magic1_timed = false
		magic1_damage = 0
		magic1_stamina_drain = 0
		magic1_mana_drain = 0
		magic1_regeneration_health = 0
		magic1_regeneration_mana = 0
		magic1_regeneration_stamina = 0
		magic1_speed = 0
		magic1_max_health = 0
		magic1_max_mana = 0
		magic1_max_stamina = 0
		magic1_self_health = 0
		magic1_self_stamina = 0
		magic1_spellTime = 0.0
		magic1_sprite_ranged = null
		magic1_sprite_player_fx = null
		magic1_projectile_speed = 0

func get_magic2_stat():
	if slots[3].item:
		magic2_damage = slots[3].item.damage
		magic2_stamina_drain = slots[3].item.stamina_drain
		magic2_mana_drain = slots[3].item.mana_drain
		magic2_regeneration_health = slots[3].item.reg_Health_Change
		magic2_regeneration_mana = slots[3].item.reg_Mana_Change
		magic2_regeneration_stamina = slots[3].item.reg_Stamina_Change
		magic2_speed = slots[3].item.player_Speed_Change
		magic2_max_health = slots[3].item.max_Health_Change
		magic2_max_mana = slots[3].item.max_Mana_Change
		magic2_max_stamina = slots[3].item.max_Stamina_Change
		magic2_type = slots[3].item.magic_type
		magic2_self_health = slots[3].item.self_heal
		magic2_self_stamina = slots[3].item.self_stamina
		magic2_spellTime = slots[3].item.time
		magic2_timed = slots[3].item.TIMED_SPELL
		magic2_sprite_ranged = slots[3].item.ranged_sprite
		magic2_sprite_player_fx = slots[3].item.player_FX_sprite
		magic2_projectile_speed = slots[3].item.projectile_speed
	
	else:
		magic2_type = null
		magic2_timed = false
		magic2_damage = 0
		magic2_stamina_drain = 0
		magic2_mana_drain = 0
		magic2_regeneration_health = 0
		magic2_regeneration_mana = 0
		magic2_regeneration_stamina = 0
		magic2_speed = 0
		magic2_max_health = 0
		magic2_max_mana = 0
		magic2_max_stamina = 0
		magic2_self_health = 0
		magic2_self_stamina = 0
		magic2_spellTime = 0.0
		magic2_sprite_ranged = null
		magic2_sprite_player_fx = null
		magic2_projectile_speed = 0

func get_equipment_stat():
	equipment_max_health = weapon_max_health + accessory_max_health
	equipment_max_mana = weapon_max_mana + accessory_max_mana + magic1_max_mana + magic2_max_mana
	equipment_max_stamina = weapon_max_stamina + accessory_max_stamina
	equipment_regeneration_health = weapon_regeneration_health + accessory_regeneration_health
	equipment_regeneration_mana = weapon_regeneration_mana + accessory_regeneration_mana + magic1_regeneration_mana + magic2_regeneration_mana
	equipment_regeneration_stamina = weapon_regeneration_stamina + accessory_regeneration_stamina
	equipment_drain_stamina = weapon_stamina_drain + accessory_stamina_drain + magic1_stamina_drain + magic2_stamina_drain
	magic1_drain = weapon_mana_drain + accessory_mana_drain + magic1_mana_drain
	magic2_drain = weapon_mana_drain + accessory_mana_drain + magic2_mana_drain

func self_cast():
	player.health += magic1_self_health + magic2_self_health
	player.stamina += magic1_self_stamina + magic2_self_stamina
