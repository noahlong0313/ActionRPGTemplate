extends Node

export(String) var player_name
export(Resource) var player_race
var player_gold = 0



#Entity Spawner
var ent = {
	"fireball": preload("res://Entities/Fireball/Fireball.tscn")
}
