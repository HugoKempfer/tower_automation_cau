extends Spatial
class_name BuildableTile

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal buildable_tile_hovered(pos)
# Called when the node enters the scene tree for the first time.

var pos: Vector3
var coords: Vector3

<<<<<<< HEAD
func pos_init(init_pos: Vector3, coords: Vector3) -> void:
	self.transform.origin = init_pos
	self.coords = coords
=======
func pos_init(init_pos: Vector3, _coords: Vector3) -> void:
	self.transform.origin = init_pos
	self.coords = _coords
>>>>>>> dev

func _on_StaticBody_mouse_entered():
	emit_signal("buildable_tile_hovered", self.transform.origin)
