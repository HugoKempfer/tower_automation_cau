extends "res://scripts/terrain/building.gd"

onready var inventory = load("res://scripts/PlayerInteface.gd").new()

func on_positioned() -> void:
	var timer = Timer.new()
	timer.set_wait_time(1.0)
	timer.set_one_shot(false)
	timer.connect("timeout", self, "add_resources")
	add_child(timer)
	timer.start()
	pass

func add_resources():
	inventory.edit_player_resource("copper", 1, true)
	inventory.edit_player_resource("coal", 1, true)
	inventory.edit_player_resource("iron", 1, true)
	inventory.edit_player_resource("lead", 1, true)
	inventory.edit_player_resource("oil", 1, true)
	inventory.edit_player_resource("uranium", 1, true)
