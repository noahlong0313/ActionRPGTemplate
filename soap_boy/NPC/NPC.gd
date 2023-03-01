extends KinematicBody2D

enum{
	IDLE
}

var state = IDLE

var can_interact = false
var player

onready var sprite = $AnimatedSprite
onready var indicator = $InteractIndicator
onready var dialog = $"%DialogBox"

func _ready():
	player = get_tree().root.get_node("/root/OverWorld/YSort/Player")

func _process(delta):
	match state:
		IDLE:
			$AnimatedSprite.play()

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
		DialogueBegin()

func DialogueBegin():
	dialog.visible = true
	dialog.dialogPath = "res://Dialog/DialogTest.json"
	can_interact = false
	dialog.startDialog()
	player.state = player.IDLE

func _on_DialogBox_dialog_ended():
	dialog.visible = false
	indicator.visible = true
	can_interact = true
	player.state = player.MOVE
