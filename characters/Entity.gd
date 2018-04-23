extends KinematicBody2D

const center = Vector2(0,0)
const left = Vector2(-1,0)
const right = Vector2(1,0)
const up = Vector2(0,-1)
const down = Vector2(0,1)
var movedir = Vector2(0,0)
var spritedir = "Down"

onready var stats = get_node("Stats")


func _physics_process(delta):
	movement_loop()
	spritedir_loop()

func _process(delta):
	if movedir != Vector2(0,0):
		anim_switch("Walk")
	else:
		anim_switch("Idle")
	if movedir.x == 1:
		get_node("Position2D/Body").flip_h = true
	elif movedir.x == -1:
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

func spritedir_loop():
	match movedir:
		Vector2(-1,0):
			spritedir = "Left"
		Vector2(1,0):
			spritedir = "Right"
		Vector2(0,-1):
			spritedir = "Up"
		Vector2(0,1):
			spritedir = "Down"

func anim_switch(animation):
	var newanim = str(animation,spritedir)
	if $Anim.current_animation != newanim:
		$Anim.play(newanim)

func movement_loop():
	var motion = movedir.normalized() * ((0.5 * log(0.125 * stats.speed)) + 0.5) * -100
	move_and_slide(motion, Vector2(0,0))