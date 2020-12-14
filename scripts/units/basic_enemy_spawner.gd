extends Spatial
class_name BasicEnemySpawner

func do_spawn() -> void:
	var new_enemy: KinematicBody = preload("res://components/units/basic_enemy.tscn").instance()
	var terrain = get_tree().get_root().get_node("GameLevel/World/Terrain")
	new_enemy.transform.origin = self.transform.origin
	new_enemy.transform.origin.y += 1
	terrain.add_child(new_enemy)


func _ready():
	pass
