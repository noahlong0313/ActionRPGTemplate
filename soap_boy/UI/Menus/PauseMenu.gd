extends Control

onready var inventoryCont = $"../InventoryContainer"

var is_paused = false setget set_is_paused

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		if inventoryCont.is_inventory_open == true:
			null
		else:
			self.is_paused = !is_paused
			$CenterContainer/VBoxContainer/SaveButton.grab_focus()

func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://UI/Menus/MainMenu.tscn")

func _on_OptionsButton_pressed():
	get_tree().change_scene("res://UI/Menus/Options.tscn")

func _on_ResumeButton_pressed():
	self.is_paused = false
