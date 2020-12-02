extends Control

const resolutions = [
	Vector2(1366, 768),                 
	Vector2(1600, 900),
	Vector2(1920, 1080), 
	Vector2(2560, 1440),
	Vector2(3200, 1800),
	Vector2(3840, 2160),
	Vector2(4096, 2160)
]

func _ready() -> void:
	$Menu/CenterRow/ButtonContainer/Cancel.grab_focus()

# Cancel and go back to MainMenu scene
func _on_Cancel_pressed() -> void:
	if get_tree().change_scene("res://scenes/MainMenu/MainMenu.tscn") != OK:
		printerr("An unexpected error occured when trying to switch to the MainMenu scene")

# Save settings and go back to MainMenu scene
func _on_Save_pressed() -> void:
	Settings.save_settings()
	apply_resolution()
	if get_tree().change_scene("res://scenes/MainMenu/MainMenu.tscn") != OK:
		printerr("An unexpected error occured when trying to switch to the MainMenu scene")

func _on_OptionButton_ready() -> void:
	var saved_resolution: Vector2
	
	saved_resolution.x = Settings.get_settings("display", "width")
	saved_resolution.y = Settings.get_settings("display", "height")
	for idx in resolutions.size():
		var string_resolution: String = "%s, %s" % [resolutions[idx].x, resolutions[idx].y]
		$Menu/CenterRow/Configuration/Window/OptionButton.add_item(string_resolution)
		if resolutions[idx].x == saved_resolution.x && resolutions[idx].y == saved_resolution.y:
			$Menu/CenterRow/Configuration/Window/OptionButton.select(idx)

func _on_OptionButton_item_selected(index) -> void:
	Settings.set_settings("display", "width", resolutions[index].x)
	Settings.set_settings("display", "height", resolutions[index].y)
	
# Change window size with save resolution
func apply_resolution() -> void:
	var saved_resolution: Vector2
	
	saved_resolution.x = Settings.get_settings("display", "width")
	saved_resolution.y = Settings.get_settings("display", "height")
	if saved_resolution.x != 0 && saved_resolution.y:
		OS.set_window_size(saved_resolution)
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_KEEP, saved_resolution)
