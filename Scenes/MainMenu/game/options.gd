extends Control

func _ready() -> void:
	$Menu/VBoxContainer/HBoxContainer/Save.grab_focus()

# Cancel edit and go back to MainMenu scene
func _on_Cancel_pressed() -> void:
	if get_tree().change_scene("res://Scenes/MainMenu/MainMenu.tscn") != OK:
		printerr("An unexpected error occured when trying to switch to the MainMenu scene")

# Save edit and go back to MainMenu scene
func _on_Save_pressed():
	if get_tree().change_scene("res://Scenes/MainMenu/MainMenu.tscn") != OK:
		printerr("An unexpected error occured when trying to switch to the MainMenu scene")
