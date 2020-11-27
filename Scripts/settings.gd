extends Node

const SAVE_PATH = "user://settings.cfg"
var config_file: ConfigFile = ConfigFile.new()

enum difficulties {
	EASY = 0,
	MEDIUM,
	DIFFICULT
}

var settings_information = {
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
	check_settings_file()
	load_settings()
	save_settings()

func save_settings() -> void:
	var error: int = OK

	for section in settings_information.keys():
		for key in settings_information[section].keys():
			config_file.set_value(section, key, settings_information[section][key])
	error = config_file.save(SAVE_PATH)
	if error:
		printerr("Failed Saving in Settings File. error code %s" % error)

func check_settings_file() -> void:
	var error = config_file.load(SAVE_PATH)

	if error:
		printerr("Failed Loading Settings File. error code %s" % error)
		error = config_file.save(SAVE_PATH)
	elif config_file.get_sections().empty():
		printerr("Settings File is empty.")
		save_settings()

func load_settings() -> void:
	var error = config_file.load(SAVE_PATH)

	if error:
		printerr("Failed Loading Settings File. error code %s" % error)
	for section in settings_information.keys():
		for key in settings_information[section].keys():
			settings_information[section][key] = config_file.get_value(section, key, null)
			print("%s: %s, %s" % [key, section, settings_information[section][key]])

func get_settings(category, key):
	return settings_information[category][key]

func set_settings(category, key, value) -> void:
	settings_information[category][key] = value
