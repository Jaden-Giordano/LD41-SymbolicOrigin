extends Node

signal _force_out_dungeon

export(int) var hunger = 0

export(int) var max_health = 20
var health = 20
export(int) var speed = 1
export(int) var strength = 1

var status = 0 # 0 = Inactive, 1 = Active, 2 = Dead

export(int) var coins = 10

var hunger_timer = 0
var hunger_health_loss_timer = 0

onready var game = get_parent()

func _ready():
	health = max_health

func _process(delta):
	if get_parent().get_name() == "Player":
		var game_stats = get_node("/root/Game/Stats")
		set_stats(game_stats)
	
	if get_parent().get_groups().has("enemies") and status == 2:
		get_node("../../").remove_child(get_parent())


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

func set_stats(new_stats):
	health = new_stats.health
	hunger = new_stats.hunger
	max_health = new_stats.max_health
	speed = new_stats.speed
	strength = new_stats.strength
	status = new_stats.status
	coins = new_stats.coins
	hunger_timer = new_stats.hunger_timer
	hunger_health_loss_timer = new_stats.hunger_health_loss_timer
