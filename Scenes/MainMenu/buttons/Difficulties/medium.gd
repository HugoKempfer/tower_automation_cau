extends Button

# Set game difficulty to Medium
func _on_Medium_pressed():
	Settings.set_settings("game_settings", "difficulty", Settings.difficulties.MEDIUM)
