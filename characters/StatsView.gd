extends Node

onready var icons = get_node("Icons")

onready var coins_label = get_node("Coins")
onready var health_bar = get_node("Bars/Health")
onready var hunger_bar = get_node("Bars/Hunger")

onready var stats = get_node("/root/Game/Stats")

func _process(delta):
    coins_label.set_text("$" + String(stats.coins))
    health_bar.max_value = stats.max_health
    health_bar.value = stats.health
    hunger_bar.value = stats.hunger

func show():
    icons.show()
    coins_label.show()
    health_bar.show()
    hunger_bar.show()

func hide():
    icons.hide()
    coins_label.hide()
    health_bar.hide()
    hunger_bar.hide() 
