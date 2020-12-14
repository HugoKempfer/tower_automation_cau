extends Spatial

export var speed: float = 10.0

var movement_direction: Vector3 = Vector3.ZERO

func _process(delta) -> void:
	self.translation.x += movement_direction.normalized().x * speed * delta

func setup(point_direction: Vector3) -> void:
	movement_direction = point_direction
