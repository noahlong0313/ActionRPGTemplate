extends Node

export(String) var player_name
export(Resource) var player_race
var player_gold = 0



#Entity Spawner
var ent = {
	"player_fx": preload("res://Entities/Player FX/PlayerFX.tscn"),
	"fireball": preload("res://Entities/Fireball/Fireball.tscn")
}
