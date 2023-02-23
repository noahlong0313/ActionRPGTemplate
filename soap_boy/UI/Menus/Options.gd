extends Control

func _ready():
	var gamepad = $GamepadCont
	var keyboard = $KeyboardCont
	$VBoxContainer/BackButton.grab_focus()

func _on_BackButton_pressed():
	get_tree().change_scene("res://UI/Menus/MainMenu.tscn")

func _on_GamepadButton_pressed():
	$GamepadCont.visible = !$GamepadCont.visible

func _on_KeyboardButton_pressed():
	$KeyboardCont.visible = !$KeyboardCont.visible
