extends Node

var health
var speed
var strength

var hunger

func _process(delta):
    if health == null: pass

func _load_stats(health, speed, strength, hunger):
    self.health = health
    self.speed = speed
    self.strength = strength
    self.hunger = hunger
