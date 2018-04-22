extends Node

signal _enter_dungeon_pressed
signal _cuddle_triggered
signal _feed_pressed
signal _speed_training_pressed
signal _strength_training_pressed
signal _training_ended

onready var stats = get_node("/root/Game/Stats")

onready var coins_label = get_node("Coins")
onready var health_bar = get_node("Bars/Health")
onready var hunger_bar = get_node("Bars/Hunger")

func _ready():
	connect("_enter_dungeon_pressed", get_parent(), "_enter_dungeon")
	connect("_feed_pressed", get_parent(), "_open_food_inventory")
	connect("_speed_training_pressed", get_parent(), "_on_speed_train")
	connect("_strength_training_pressed", get_parent(), "_on_strength_train")
	connect("_training_ended", get_parent(), "_on_training_ended")

func _process(delta):
	coins_label.set_text("$" + String(stats.coins))
	health_bar.max_value = stats.max_health
	health_bar.value = stats.health
	hunger_bar.value = stats.hunger

func _on_enter_dungeon_pressed():
	emit_signal("_enter_dungeon_pressed")

func _on_feed_pressed():
	emit_signal("_feed_pressed")

func _on_speed_training_pressed():
	if stats.status == 0:
		emit_signal("_speed_training_pressed")
		get_node("SpeedTrainTimer").start()

func _on_strength_training_pressed():
	if stats.status == 0:
		emit_signal("_strength_training_pressed")
		get_node("StrengthTrainTimer").start()

func _training_ended(type):
	emit_signal("_training_ended", type)
