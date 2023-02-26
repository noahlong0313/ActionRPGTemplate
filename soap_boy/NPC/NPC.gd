extends KinematicBody2D

enum{
	IDLE,
	DIALOGUE
}

var state = IDLE

onready var sprite = $AnimatedSprite

func _ready():
	var dialogue_resource = preload("res://Dialouge/test.tres")
	var dialogue_line = yield(DialogueManager.get_next_dialogue_line("start", dialogue_resource), "completed")

func _process(delta):
	match state:
		IDLE:
			pass
		DIALOGUE:
			pass
