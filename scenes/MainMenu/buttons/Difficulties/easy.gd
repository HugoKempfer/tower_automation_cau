extends Button

# Set game difficulty to Easy
func _on_Easy_pressed():
	Settings.set_settings("game_settings", "difficulty", Settings.difficulties.EASY)
