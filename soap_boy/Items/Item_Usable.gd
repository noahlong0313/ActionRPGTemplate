extends Item

class_name Item_Usable

onready var cooldownTimer = $CooldownTimer
onready var cooldownProgress = $CooldownProgress
onready var cooldownLabel = $CooldownLabel

#Consumable
export(int) var health_Restored
export(int) var stamina_Restored
export(int) var mana_Restored

#Cooldown
export(float) var cooldown_time

var player
var can_use
var in_cooldown = false

var item : Item

func _ready():
	player = get_tree().root.get_node("/root/OverWorld/YSort/Player")

func _process(_delta):
	if in_cooldown == true:
		cooldownProgress.value = cooldownTimer.time_left
		cooldownLabel.text = str(cooldownProgress.value)

func useItem(target):
	.useItem(target)
	player.health += health_Restored
	player.mana += mana_Restored
	player.stamina += stamina_Restored
	
	set_cooldown()
	start_cooldown()

func set_cooldown():
	cooldownTimer.wait_time = cooldown_time

func start_cooldown():
	cooldownProgress.max_value = cooldown_time
	cooldownProgress.visible = true
	cooldownLabel.visible = true
	
	cooldownTimer.start()
	in_cooldown = true

func _on_CooldownTimer_timeout():
	in_cooldown = false
	cooldownProgress.visible = false
	cooldownLabel.visible = false
