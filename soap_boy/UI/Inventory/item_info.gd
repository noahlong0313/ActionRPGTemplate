extends NinePatchRect

class_name Item_Info

export(NodePath) onready var item_name = get_node(item_name) as Label

onready var item_description_cont = $item_info_container
onready var item_description = $item_info_container/item_desc_Label

onready var damage_label = $item_info_container/Damage
onready var maxHealth_label = $item_info_container/MaxHealth
onready var regHealth_label = $item_info_container/RegHealth
onready var maxMana_label = $item_info_container/MaxMana
onready var regMana_label = $item_info_container/RegMana
onready var costMana_label = $item_info_container/CostMana
onready var maxStamina_label = $item_info_container/MaxStamina
onready var regStamina_label = $item_info_container/RegStamina
onready var costStamina_label = $item_info_container/CostStamina

onready var incHealth_label = $item_info_container/IncreaseHealth
onready var incMana_label = $item_info_container/IncreaseMana
onready var incStamina_label = $item_info_container/IncreaseStamina

var equipment
var item : Item

func _ready():
	equipment = get_node("/root/OverWorld/CanvasLayer/inventory_player/inventory_cont/equipment")


func display(slot : Inventory_Slot):
	rect_global_position = slot.rect_size + slot.rect_global_position
	item_name.text = slot.item.item_name
	item_description.text = slot.item.item_desc
	if slot.item.USEABLE == true:
		show_usable_stats(slot)
		get_useable_stats(slot)
		damage_label.visible = false
		maxHealth_label.visible = false
		regHealth_label.visible = false
		maxMana_label.visible = false
		regMana_label.visible = false
		costMana_label.visible = false
		maxStamina_label.visible = false
		regStamina_label.visible = false
		costStamina_label.visible = false
	elif slot.item.EQUIPMENT == true:
		show_item_stats(slot)
		get_item_stats(slot)
		incHealth_label.visible = false
		incMana_label.visible = false
		incStamina_label.visible = false
	show()
	yield(get_tree(), "idle_frame")
	rect_size.y = item_description_cont.rect_size.y + 9

func show_item_stats(slot : Inventory_Slot):
	if slot.item.damage == 0:
		damage_label.visible = false
	else:
		damage_label.visible = true
	
	if slot.item.max_Health_Change == 0:
		maxHealth_label.visible = false
	else:
		maxHealth_label.visible = true
	
	if slot.item.reg_Health_Change == 0:
		regHealth_label.visible = false
	else:
		regHealth_label.visible = true
	
	if slot.item.max_Mana_Change == 0:
		maxMana_label.visible = false
	else:
		regMana_label.visible = true
	
	if slot.item.reg_Mana_Change == 0:
		regMana_label.visible = false
	else:
		regMana_label.visible = true
	
	if slot.item.mana_drain == 0:
		costMana_label.visible = false
	else:
		costMana_label.visible = true
	
	if slot.item.max_Stamina_Change == 0:
		maxStamina_label.visible = false
	else:
		maxStamina_label.visible = true
	
	if slot.item.reg_Stamina_Change == 0:
		regStamina_label.visible = false
	else:
		regStamina_label.visible = true
	
	if slot.item.stamina_drain == 0:
		costStamina_label.visible = false
	else:
		costStamina_label.visible = true

func show_usable_stats(slot : Inventory_Slot):
	if slot.item.health_Restored == 0:
		incHealth_label.visible = false
	else:
		incHealth_label.visible = true
	
	if slot.item.mana_Restored == 0:
		incMana_label.visible = false
	else:
		incMana_label.visible = true
	
	if slot.item.stamina_Restored == 0:
		incStamina_label.visible = false
	else:
		incStamina_label.visible = true

func get_item_stats(slot : Inventory_Slot):
	damage_label.text = str(slot.item.damage) + " : Damage"
	maxHealth_label.text = str(slot.item.max_Health_Change) + " : Max Health"
	regHealth_label.text = str(slot.item.reg_Health_Change) + " : Health Regen"
	maxMana_label.text = str(slot.item.max_Mana_Change) + " : Max Mana"
	regMana_label.text = str(slot.item.reg_Mana_Change) + " : Mana Regen"
	costMana_label.text = str(slot.item.mana_drain) + " : Mana Cost"
	maxStamina_label.text = str(slot.item.max_Stamina_Change) + " : Max Stamina"
	regStamina_label.text = str(slot.item.reg_Stamina_Change) + " : Mana Stamina"
	costStamina_label.text = str(slot.item.stamina_drain) + " : Stamina Cost"

func get_useable_stats(slot : Inventory_Slot):
	incHealth_label.text = "+" + str(slot.item.health_Restored) + " HEALTH"
	incMana_label.text = "+" + str(slot.item.mana_Restored) + " MANA"
	incStamina_label.text = "+" + str(slot.item.stamina_Restored) + " STAMINA"
