extends Control

func _ready():
	$VBoxContainer/StartButton.grab_focus()
	DayNightModule.visible = false

func _on_StartButton_pressed():
	get_tree().change_scene("res://OverWorld.tscn")
	DayNightModule.visible = true

func _on_OptionsButton_pressed():
	get_tree().change_scene("res://UI/Menus/Options.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()
