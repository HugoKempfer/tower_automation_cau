extends Button

# Set game difficulty to Hard
func _on_Hard_pressed():
	Settings.set_settings("game_settings", "difficulty", Settings.difficulties.HARD)
