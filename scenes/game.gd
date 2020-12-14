extends Node

onready var bullet_container = $World/BulletContainer

func _fire_bullet(origin: Vector3, direction: Basis, bullet, target=null) -> void:
	var instanced_bullet = bullet.instance()
	if target:
		instanced_bullet.target = target
	instanced_bullet.transform.basis = direction
	instanced_bullet.transform.origin = origin
	bullet_container.add_child(instanced_bullet)
