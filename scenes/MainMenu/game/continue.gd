extends Control

func _ready() -> void:
	$Menu/VBoxContainer/HBoxContainer/Play.grab_focus()

# Go to game scene
func _on_Play_pressed():
	if get_tree().change_scene("res://scenes/game.tscn") != OK:
		printerr("An unexpected error occured when trying to switch to the game scene")

# Go back to MainMenu scene
func _on_Back_pressed() -> void:
	if get_tree().change_scene("res://scenes/MainMenu/MainMenu.tscn") != OK:
		printerr("An unexpected error occured when trying to switch to the MainMenu scene")
