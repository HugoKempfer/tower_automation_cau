extends Control

func _ready() -> void:
	$Menu/CenterRow/ButtonContainer/Save.grab_focus()
		#if array_has_property(props, "scene_to_load"):
		#	button.connect("pressed", self, "on_button_pressed", [button.scene_to_load])

# Cancel and go back to MainMenu scene
func _on_Cancel_pressed() -> void:
	if get_tree().change_scene("res://Scenes/MainMenu/MainMenu.tscn") != OK:
		printerr("An unexpected error occured when trying to switch to the MainMenu scene")

# Save settings and go back to MainMenu scene
func _on_Save_pressed():
	Settings.save_settings()
	if get_tree().change_scene("res://Scenes/MainMenu/MainMenu.tscn") != OK:
		printerr("An unexpected error occured when trying to switch to the MainMenu scene")
