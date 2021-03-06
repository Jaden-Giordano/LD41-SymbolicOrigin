extends Node

signal _force_out_dungeon

export(int) var hunger = 0

export(int) var max_health = 20
var health = 20
export(int) var speed = 1
export(int) var strength = 1
export var color = Color()

var status = 0 # 0 = Inactive, 1 = Active, 2 = Dead

export(int) var coins = 10

export(float) var attack_push = 5000

var hunger_timer = 0
var hunger_health_loss_timer = 0

onready var game = get_parent()

func _ready():
	health = max_health

func _process(delta):
	if game.get_name() == "Game" && game.is_playing():
		hunger_timer += delta
		if hunger_timer >= 1:
			hunger_timer = 0
			if status == 0:
				hunger += 0.25
			elif status == 1:
				hunger += 10
		hunger = clamp(hunger, 0, 100)

		if hunger >= 100:
			hunger_health_loss_timer += delta
			if hunger_health_loss_timer >= 1:
				hunger_health_loss_timer = 0
				health -= 0.5
	if health <= 0 && status != 2:
		health = 0
		status = 2
		if get_parent().get_name() == "Game":
			emit_signal("_force_out_dungeon")

func _physics_process(delta):
	if get_parent().get_groups().has("enemies") and status == 2:
		get_node("../../").remove_child(get_parent())

func eat_food(type):
	match type:
		0:
			hunger -= 100
			health += max_health / 4
		1: # Nutritious (Health)
			hunger -= 100
			max_health += 5
			health += 5
			speed -= 1
			if speed <= 0: speed = 1
		2: # Vitamins (Speed)
			health += 5
			hunger -= 100
			speed += 3
		3: # Protien (Strength)
			hunger -= 100
			health += 10
			strength += 2
			if speed <= 0: speed = 1
	
	if status == 2: status = 0

	hunger = clamp(hunger, 0, 100)
	health = clamp(health, 0, max_health)

func reset():
	hunger = 0
	strength = 1
	speed = 1
	max_health = 20
	health = max_health
	status = 0
