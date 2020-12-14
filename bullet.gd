extends Area

export var speed: float = 10.0

var movement_direction: Vector3 = Vector3.ZERO

func _ready():
	$Timer.start()

func _physics_process(delta) -> void:
	transform.origin += (transform.basis.z * speed * delta)

func setup(point_direction: Vector3) -> void:
	movement_direction = point_direction

func _on_Timer_timeout():
	queue_free()

func _on_Bullet_body_entered(body):
	print("Entered %s" % body)
	# Destroy body if it is an enemy
	if body.is_in_group('enemy'):
		body.queue_free()
	# If the player is hit
	if body.is_in_group('player'):
		pass
	# Destroy Bullet
	queue_free()


func _on_Bullet_body_shape_entered(body_id, body, body_shape, area_shape):
	print("E 1")
	pass # Replace with function body.


func _on_Bullet_area_shape_entered(area_id, area, area_shape, self_shape):
	print("E 2")
	pass # Replace with function body.


func _on_Bullet_area_entered(area):
	print("E 3")
	pass # Replace with function body.


func _on_Bullet_area_exited(area):
	print("E 3")
	pass # Replace with function body.


func _on_Bullet_area_shape_exited(area_id, area, area_shape, self_shape):
	print("E 3")
	pass # Replace with function body.


func _on_Bullet_body_exited(body):
	print("E 3")
	pass # Replace with function body.
