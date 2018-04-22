extends Node

signal _force_out_dungeon

var hunger = 0

var health = 20
var max_health = 20
var speed = 1
var strength = 1

var status = 0 # 0 = Inactive, 1 = Active, 2 = Dead

var coins = 10

var hunger_timer = 0
var hunger_health_loss_timer = 0

onready var game = get_parent()

func _process(delta):
	if game.get_name() == "Game" && game.is_playing():
		hunger_timer += delta
		if hunger_timer >= 1:
			hunger_timer = 0
			if status == 0:
				hunger += 0.25
			elif status == 1:
				hunger += 5
		hunger = clamp(hunger, 0, 100)

		if hunger == 100:
			hunger_health_loss_timer += delta
			if hunger_health_loss_timer >= 1:
				hunger_health_loss_timer = 0
				if status == 0:
					health -= 0.5
		if health < 0:
			health = 0
			status = 2
			emit_signal("_force_out_dungeon")

func eat_food(type):
	match type:
		0: # Nutritious (Health)
			hunger -= 100
			max_health += 5
			health += 5
			speed -= 1
		1: # Vitamins (Speed)
			hunger -= 100
			speed += 1
		2: # Protien (Strength)
			hunger -= 100
			speed -= 1
			strength += 1
	
	hunger = clamp(hunger, 0, 100)
	health = clamp(health, 0, max_health)
