extends Item

class_name Item_Equipment

export(bool) var MAGIC

export(GameEnums.MAGIC_TYPE) var magic_type

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

# Magic Type

var item : Item


