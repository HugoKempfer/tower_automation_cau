extends Node

const SAVE_PATH = "user://settings.cfg"
var config_file: ConfigFile = ConfigFile.new()

enum difficulties {
	EASY = 0,
	MEDIUM,
	HARD
}

var settings = {
	"color": {
		"body_color1": Color(1, 1, 1, 1),
		"body_color2": Color(0, 0, 0, 1)
	},
	"player_info": {
		"player_name": "Default Name"
	},
	"display": {
		"width": 1366,
		"height": 768,
		"brightness": 100
	},
	"audio": {
		"music": true,
		"sound": true
	},
	"game_settings": {
		"difficulty": difficulties.MEDIUM
	}
}

func _ready() -> void:
	init_settings_file()
	load_settings()

func init_settings_file() -> void:
	var error: int = config_file.load(SAVE_PATH)

	if error != OK && error != ERR_FILE_NOT_FOUND:
		printerr("Failed Loading Settings File. error code %s" % error)
		return
	for section in settings.keys():
		for key in settings[section]:
			if config_file.get_value(section, key, null) == null:
				config_file.set_value(section, key, settings[section][key])
	error = config_file.save(SAVE_PATH)
	if error != OK:
		printerr("Failed Saving in Settings File. error code %s" % error)

func save_settings() -> void:
	var error: int = OK

	for section in settings.keys():
		for key in settings[section]:
			config_file.set_value(section, key, settings[section][key])
	error = config_file.save(SAVE_PATH)
	if error != OK:
		printerr("Failed Saving in Settings File. error code %s" % error)

func load_settings() -> void:
	var error: int = config_file.load(SAVE_PATH)

	if error != OK:
		printerr("Failed Loading Settings File. error code %s" % error)
		return
	for section in settings.keys():
		for key in settings[section].keys():
			settings[section][key] = config_file.get_value(section, key, null)

func get_settings(category, key):
	return settings[category][key]

func set_settings(category, key, value) -> void:
	settings[category][key] = value
