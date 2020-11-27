extends Control

export(String) var player_name: String

func _ready() -> void:
	$Menu/VBoxContainer/HBoxContainer/Play.grab_focus()

# Go to game scene
func _on_Play_pressed():
	if get_tree().change_scene("res://Scenes/game.tscn") != OK:
		printerr("An unexpected error occured when trying to switch to the game scene")

# Go back to MainMenu scene
func _on_Back_pressed():
	if get_tree().change_scene("res://Scenes/MainMenu/MainMenu.tscn") != OK:
		printerr("An unexpected error occured when trying to switch to the MainMenu scene")

func _on_YourNameLineEdit_text_changed(new_text: String):
	player_name = new_text
