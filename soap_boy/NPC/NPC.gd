extends KinematicBody2D

enum{
	IDLE,
	DIALOGUE
}

var state = IDLE

var can_interact = false

onready var sprite = $AnimatedSprite
onready var indicator = $InteractIndicator
onready var dialog = $"%DialogBox"

func _process(delta):
	match state:
		IDLE:
			$AnimatedSprite.play()
		DIALOGUE:
			dialog.visible = true
			dialog.dialogPath = "res://Dialog/DialogTest.json"
			print("test")
			if dialog.finished == true:
				dialog.visible = false
				indicator.visible = true
				state = IDLE

func _on_InteractArea2D_body_entered(body):
	if body.name == "Player":
		indicator.visible = true
		can_interact = true

func _on_InteractArea2D_body_exited(body):
	if body.name == "Player":
		indicator.visible = false
		can_interact = false

func _input(event):
	if Input.is_action_just_pressed("interact") and can_interact == true:
		indicator.visible = false
		state = DIALOGUE
