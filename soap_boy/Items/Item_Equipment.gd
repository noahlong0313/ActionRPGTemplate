extends Item

class_name Item_Equipment

export(GameEnums.WEAPON_TYPE) var weapon_type

export(bool) var MAGIC

export(GameEnums.MAGIC_TYPE) var magic_type

export(SpriteFrames) var ranged_sprite

export(int) var projectile_speed = 0

export(SpriteFrames) var player_FX_sprite

# Weapons / Attacks
export(int) var damage = 0
export(float) var stamina_drain = 0 
export(float) var mana_drain = 0

# Movement
export(int) var player_Speed_Change = 0 

# Max Stats
export(int) var max_Health_Change = 0
export(int) var max_Stamina_Change = 0
export(int) var max_Mana_Change = 0

# Reg Stats
export(float) var reg_Health_Change = 0
export(float) var reg_Stamina_Change = 0
export(float) var reg_Mana_Change = 0

# Self Spells
export(int) var self_heal
export(int) var self_stamina

export(bool) var TIMED_SPELL

export(float) var time
