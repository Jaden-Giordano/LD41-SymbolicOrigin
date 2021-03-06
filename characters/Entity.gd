extends KinematicBody2D

signal _end_game

const center = Vector2(0,0)
const left = Vector2(-1,0)
const right = Vector2(1,0)
const up = Vector2(0,-1)
const down = Vector2(0,1)
var movedir = Vector2(0,0)
var spritedir = "Down"
export var sprite = 1

var damaged = false
var push_direction = Vector2(0, 0)
var push_counter = 0
var push_time = 0.2

export var invincible = false

var stats

func _ready():
	get_node("Position2D/Body").set_texture(load(String("res://assets/pets/pet"+String(sprite)+".png")))
	if get_name() == "Player":
		stats = get_node("/root/Game/Stats")
	else:
		stats = get_node("Stats")
	modulate = stats.color

	connect("_end_game", get_node("/root/Game"), "_end_game")

func _physics_process(delta):
	movement_loop(delta)
	spritedir_loop()

func _process(delta):
	if damaged:
		push_counter += delta
		if push_counter >= push_time:
			damaged = false
			push_direction = Vector2(0, 0)
			push_counter = 0

	if movedir != Vector2(0,0):
		anim_switch("Walk")
	else:
		anim_switch("Idle")
	if movedir.x == 1:
		get_node("Position2D/Body").flip_h = true
	elif movedir.x == -1:
		get_node("Position2D/Body").flip_h = false
	
	if get_groups().has("enemies"):
		var bodies = []
		for body in get_node("AttackRadius").get_overlapping_bodies():
			if body.get_name() == "Player":
				bodies.append(body)
		attack(bodies)

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

func movement_loop(delta):
	var motion = movedir.normalized() * ((0.5 * log((0.125 * stats.speed) + 1)) + 0.5) * 100
	if damaged:
		motion = push_direction * stats.attack_push * delta
	move_and_slide(motion, Vector2(0,0))

func attack(objects):
	for o in objects:
		var away_dir = ((o.position + o.get_parent().position) - self.position).normalized()
		if o.get_name() == "Player":
			away_dir = (o.position - (self.position + self.get_parent().position)).normalized()
		var damage = floor((1.2 * log(stats.strength + 1)) + 1) * 5
		o.damage(damage, away_dir, self)

func damage(amt, dir, from):
	if !invincible:
		damaged = true
		$sound/hit.play()
		stats.health -= amt
		if stats.health <= 0:
			get_node("/root/Game/death").play()
			stats.health = 0
			if get_name() == "Boss":
				emit_signal("_end_game")
			if from != null:
				get_node("/root/Game/DropFactory").create_drop(self.global_position)
		
		if dir != null:
			push_direction = dir

		if get_name() == "Player":
			$Effects.set_current_animation("Invincible")
		else:
			$Effects.set_current_animation("Hurt")

func reward(amt):
	stats.coins += amt

func pickup(health, hunger, speed, strength, coins):
	stats.health += health
	stats.health = clamp(stats.health, 0, stats.max_health)
	stats.hunger -= hunger
	stats.hunger = clamp(stats.hunger, 0, 100)
	stats.speed += speed
	stats.strength += strength
	stats.coins += coins
