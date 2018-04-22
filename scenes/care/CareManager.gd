extends Node

signal _enter_dungeon_pressed
signal _cuddle_triggered
signal _feed_pressed

onready var stats = get_node("/root/Game/Stats")

onready var coins_label = get_node("Coins")
onready var health_bar = get_node("Bars/Health")
onready var hunger_bar = get_node("Bars/Hunger")

func _ready():
	connect("_enter_dungeon_pressed", get_parent(), "_enter_dungeon")
	connect("_feed_pressed", get_parent(), "_open_food_inventory")

func _process(delta):
	coins_label.set_text("$" + String(stats.coins))
	health_bar.max_value = stats.max_health
	health_bar.value = stats.health
	hunger_bar.value = stats.hunger

func _on_enter_dungeon_pressed():
	emit_signal("_enter_dungeon_pressed")

func _on_feed_pressed():
	emit_signal("_feed_pressed")
