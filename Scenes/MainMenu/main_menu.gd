extends Control

var scene_path_to_load: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Menu/CenterRow/MenuOptions/ContinueButton.grab_focus()
	for button in $Menu/CenterRow/MenuOptions.get_children():
		var props = button.get_script().get_script_property_list()
		if array_has_property(props, "scene_to_load"):
			button.connect("pressed", self, "on_button_pressed", [button.scene_to_load])

func array_has_property(props: Array, property: String) -> bool:
	for prop in props:
		if prop.usage & PROPERTY_USAGE_SCRIPT_VARIABLE:
			if prop.name == property:
				return true
		else:
			return false
	return false

# Go to specified scene
func on_button_pressed(scene_to_load: String) -> void:
	scene_path_to_load = scene_to_load
	$Click.play()
	$FadeIn.show()
	$FadeIn.fade_in()

# Change scene when fade animation is over
func _on_FadeIn_fade_finished() -> void:
	if get_tree().change_scene(scene_path_to_load) != OK:
		printerr("An unexpected error occured when trying to switch to the ", scene_path_to_load, " scene")

