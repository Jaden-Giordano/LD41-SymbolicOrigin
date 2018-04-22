extends "res://characters/Entity.gd"

func _ready():
    set_physics_process(true);

func _physics_process(delta):
	movedir = Vector2(0, 0)

	if Input.is_action_pressed("move_left"):
		movedir.x -= 1
		get_node("Position2D/Body").flip_h = false
	if Input.is_action_pressed("move_right"):
		movedir.x += 1
		get_node("Position2D/Body").flip_h = true
	if Input.is_action_pressed("move_up"):
		movedir.y -= 1
	if Input.is_action_pressed("move_down"):
		movedir.y += 1