# Every building have to inheritate this class
extends Node
class_name Building

export var size: int
var tile_pos: Vector3
var is_positioned: bool = false

func on_positioned() -> void:
	pass
