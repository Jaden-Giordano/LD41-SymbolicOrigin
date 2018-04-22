extends KinematicBody2D

const center = Vector2(0,0)
const left = Vector2(-1,0)
const right = Vector2(1,0)
const up = Vector2(0,-1)
const down = Vector2(0,1)
var movedir = Vector2(0,0)
const SPEED = 0

func _physics_process(delta):
	movement_loop()

func _process(delta):
	if movedir.x == 1:
		get_node("Position2D/Body").flip_h = true
	else:
		get_node("Position2D/Body").flip_h = false

func rand():
	var d = randi() % 8 + 1
	match d:
		1:
			return left
		2: 
			return right
		3:
			return up
		4: 
			return down
		5:
			return left+up
		6: 
			return right+up
		7:
			return left+down
		8: 
			return right+down

func movement_loop():
	var motion = movedir.normalized() * SPEED
	move_and_slide(motion, Vector2(0,0))