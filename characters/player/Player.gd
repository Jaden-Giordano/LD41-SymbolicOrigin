extends "res://characters/Entity.gd"

export(float) var attack_cooldown = 0.5
export(String) var attack_scene

var attack_scene_loaded

var has_attacked = false
var attack_counter = 0

func _ready():
	set_physics_process(true);
	attack_scene_loaded = load(attack_scene)

func _process(delta):
	if has_attacked:
		attack_counter += delta
		if attack_counter >= attack_cooldown:
			has_attacked = false
	
	if Input.is_action_just_pressed("attack") and !has_attacked:
		attack_anim()
		has_attacked = true
		attack_counter = 0
		var enemies = []
		for body in get_node("AttackRadius").get_overlapping_bodies():
			if body.get_groups().has("enemies"):
				enemies.append(body)
		attack(enemies)

func attack_anim():
	var attack_point = get_node("AttackRadius/AttackPoint")
	var attack_anim = attack_scene_loaded.instance()
	get_parent().add_child(attack_anim)
	get_node("../AttackAnimation").global_position = attack_point.global_position
	get_node("../AttackAnimation/Anim").set_current_animation("Default")

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
