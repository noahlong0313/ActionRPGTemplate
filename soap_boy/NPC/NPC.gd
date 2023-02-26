extends KinematicBody2D

enum{
	IDLE,
	DIALOGUE
}

var state = IDLE

onready var sprite = $AnimatedSprite

func _ready():
	pass

func _process(delta):
	match state:
		IDLE:
			pass
		DIALOGUE:
			pass
