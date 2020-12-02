extends Control

func _ready() -> void:
	$Menu/CenterRow/HBoxContainer/Play.grab_focus()

# Go to game scene
func _on_Play_pressed() -> void:
	Settings.save_settings()
	if get_tree().change_scene("res://Scenes/game.tscn") != OK:
		printerr("An unexpected error occured when trying to switch to the game scene")

# Go back to MainMenu scene
func _on_Back_pressed() -> void:
	if get_tree().change_scene("res://Scenes/MainMenu/MainMenu.tscn") != OK:
		printerr("An unexpected error occured when trying to switch to the MainMenu scene")

func _on_YourNameLineEdit_text_changed(new_text: String) -> void:
	Settings.set_settings("player_info", "player_name", new_text)

func _on_BrightnessSlider_value_changed(value: int) -> void:
	Settings.set_settings("display", "brightness", value)

# Initialize BrightnessSlider with value from settings.cfg
func _on_BrightnessSlider_ready():
	print(Settings.get_settings("display", "brightness"))
	$Menu/CenterRow/Configuration/BrightnessContainer/BrightnessSlider.value = Settings.get_settings("display", "brightness")
