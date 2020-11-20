extends Control

# Go back to MainMenu scene
func _on_Button_pressed() -> void:
	if get_tree().change_scene("res://Scenes/MainMenu.tscn") != OK:
		printerr("An unexpected error occured when trying to switch to the MainMenu scene")
