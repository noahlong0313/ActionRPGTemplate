extends VBoxContainer

onready var actionLabel = $ActionLabel
onready var objectLabel = $ObjectLabel

func display(interactable):
	actionLabel.text = interactable.action
	objectLabel.text = interactable.object_name
	show()
