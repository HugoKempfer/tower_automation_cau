extends Timer
class_name WaveSpawner

export var wave_intervals: int = 5
var current_wave := 0

func _ready():
	self.start(self.wave_intervals)

func _process(delta: float) -> void:
	($CounterLabel as Label).text = "Next wave in: %s" % int(self.time_left)

func _on_WaveSpawner_timeout():
	self.stop()
	self.current_wave += 1
	var enemy_to_spawn = self.current_wave * 2
	while enemy_to_spawn > 0:
		for spawner in get_tree().get_nodes_in_group("spawner"):
			(spawner as BasicEnemySpawner).do_spawn()
			enemy_to_spawn -= 1
			if enemy_to_spawn <= 0:
				break
