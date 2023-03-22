extends Inventory

export(NodePath) onready var accessory = get_node(accessory) as Inventory_Slot
export(NodePath) onready var weapon = get_node(weapon) as Inventory_Slot
export(NodePath) onready var magic_1 = get_node(magic_1) as Inventory_Slot
export(NodePath) onready var magic_2 = get_node(magic_2) as Inventory_Slot

#Damage
var weapon_damage
var magic1_damage
var magic2_damage
#Added on ^
var accessory_damage
#Drain
var weapon_stamina_drain
var weapon_mana_drain
var magic1_stamina_drain
var magic1_mana_drain
var magic2_stamina_drain
var magic2_mana_drain

#Regeneration
##Total from all equipment
var equipment_regeneration_health
var equipment_regeneration_mana
var equipment_regeneration_stamina
##Individual Reg Values
var weapon_regeneration_health
var weapon_regeneration_mana
var weapon_regeneration_stamina
var accessory_regeneration_health
var accessory_regeneration_mana
var accessory_regeneration_stamina
var magic1_regeneration_health
var magic1_regeneration_mana
var magic1_regeneration_stamina
var magic2_regeneration_health
var magic2_regeneration_mana
var magic2_regeneration_stamina

#Movement
var weapon_speed
var accessory_speed
var magic1_speed
var magic2_speed

#Max Stat
##Total from all equipment
var equipment_max_health
var equipment_max_mana
var equipment_max_stamina
##Individual Max Values
var weapon_max_health
var weapon_max_mana
var weapon_max_stamina
var accessory_max_health
var accessory_max_mana
var accessory_max_stamina
var magic1_max_health
var magic1_max_mana
var magic1_max_stamina
var magic2_max_health
var magic2_max_mana
var magic2_max_stamina

var item : Item

func _ready():
	slots.append(accessory)
	slots.append(weapon)
	slots.append(magic_1)
	slots.append(magic_2)
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
	
	else:
		return null

func get_equipment_stats():
	var equipment_max_health = weapon_max_health + accessory_max_health + magic1_max_health + magic2_max_health
	var equipment_max_mana = weapon_max_mana + accessory_max_mana + magic1_max_mana + magic2_max_mana
	var equipment_max_stamina = weapon_max_stamina + accessory_max_stamina + magic1_max_stamina + magic2_max_stamina
	var equipment_regeneration_health = weapon_regeneration_health + accessory_regeneration_health + magic1_regeneration_health + magic2_regeneration_health
	var equipment_regeneration_mana = weapon_regeneration_mana + accessory_regeneration_mana + magic1_regeneration_mana + magic2_regeneration_mana
	var equipment_regeneration_stamina = weapon_regeneration_stamina + accessory_regeneration_stamina + magic1_regeneration_stamina + magic2_regeneration_stamina



