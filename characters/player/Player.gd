extends "res://characters/Entity.gd"

export(int) var attack_cooldown = 1.5

var has_attacked = false
var attack_counter = 0

func _ready():
    set_physics_process(true);

func _process(delta):
	if has_attacked:
		attack_counter += delta
		if attack_counter >= attack_cooldown:
			has_attacked = false
	elif Input.is_action_just_pressed("attack"):
		has_attacked = true
		attack_counter = 0
		var enemies = []
		for body in get_node("AttackRadius").get_overlapping_bodies():
			if body.get_groups().has("enemies"):
				enemies.append(body)
		attack(enemies)

func _physics_process(delta):
	movedir = Vector2(0, 0)
	
	var attack_area = get_node("AttackRadius")

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
	
	if movedir != Vector2(0, 0):
		attack_area.rotation = movedir.angle() - deg2rad(90)
