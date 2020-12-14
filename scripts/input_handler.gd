# This script is meant to be used to interpret player input

extends Node

var fast_move_start = Vector2()
var selecting_start = Vector2(0,0)
export var fast_move = 0
export var rotating_camera = 0
#onready var game = get_node("/root/game")
onready var camera_anchor = get_node("/root/GameLevel/World/camera_anchor")

func _ready():
	set_process_input(true)

func _process(_delta):
		#print(get_viewport().get_mouse_position().snapped(Vector2(64, 64)))
		pass

func _input(event):
	# UI functionality
	if event.is_action_pressed("camera_rotate"):
		rotating_camera = 1
		camera_anchor.start_moving_camera()

	if event.is_action_released("camera_rotate"):
		rotating_camera = 0
		camera_anchor.stop_camera()

	if event.is_action_pressed("camera_fast_move"):
		fast_move = 1
		fast_move_start = event.position
		camera_anchor.start_moving_camera()

	if event.is_action_released("camera_fast_move"):
		fast_move = 0
		camera_anchor.stop_camera()

	if rotating_camera and event is InputEventMouseMotion:
		camera_anchor.rotate_camera(event.relative.x*0.005)

	if fast_move and event is InputEventMouseMotion:
		camera_anchor.change_direction(event.relative.x, event.relative.y)

func mouse2coords(event):
	var near = camera_anchor.get_node("camera").project_ray_origin(event.position)
	var far = near + camera_anchor.get_node("camera").project_ray_normal(event.position)*100
	var point = get_node("/root/game/game_world/environment/map/navigation").get_closest_point_to_segment(near, far)
	return point

func is_point_in_rectangle(point, rect_start, rect_end):
	var x = point.x
	var y = point.y
	if ( (rect_start.x > x and x > rect_end.x) or (rect_start.x  < x and x < rect_end.x )):
		if ( ( rect_start.y > y and y > rect_end.y) or (rect_start.y < y and y < rect_end.y )):
			return true
	return false
