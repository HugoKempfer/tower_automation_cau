extends Building

class_name Turret

export var rotation_speed: float = 25.0
export var bullet: PackedScene

onready var body := $StaticBody
onready var ray := $Pointer/RayCast
onready var canon := $Canon

signal fire_bullet

var can_shoot: bool = true

func _ready() -> void:
	for node in get_tree().get_nodes_in_group("game"):
		if connect("fire_bullet", node, "_fire_bullet") != OK:
			printerr("Unexpected error while connecting to method _fire_bullet")

func _process(delta) -> void:
	self.rotation_degrees.y += rotation_speed * delta
	aim()

func aim() -> void:
	if can_shoot and ray.is_colliding():
		if ray.get_collider().is_in_group("core"): # Issue, trouble to detect object from group "core"
			shoot()
			reload()

func shoot() -> void:
	var origin = canon.global_transform.origin
	var direction = canon.global_transform.basis
	emit_signal("fire_bullet", origin, direction, bullet)

func reload() -> void:
	$ShotTimer.start()
	can_shoot = false

func _on_ShotTimer_timeout():
	can_shoot = true
