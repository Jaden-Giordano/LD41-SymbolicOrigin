extends Node

onready var icons = get_node("Icons")

onready var coins_label = get_node("Coins")
onready var health_bar = get_node("Bars/Health")
onready var hunger_bar = get_node("Bars/Hunger")
onready var speed_label = get_node("Speed")
onready var strength_label = get_node("Strength")

onready var stats = get_node("/root/Game/Stats")

func _process(delta):
    coins_label.set_text("$" + String(stats.coins))
    health_bar.max_value = stats.max_health
    health_bar.value = stats.health
    hunger_bar.value = stats.hunger
    speed_label.set_text("Speed: " + String(stats.speed))
    strength_label.set_text("Strength: " + String(stats.strength))

func show():
    icons.show()
    coins_label.show()
    health_bar.show()
    hunger_bar.show()
    speed_label.show()
    strength_label.show()

func hide():
    icons.hide()
    coins_label.hide()
    health_bar.hide()
    hunger_bar.hide()
    speed_label.hide()
    strength_label.hide()
