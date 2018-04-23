extends Node

signal _close_pressed

onready var music_volume = get_node("Display/Music")
onready var sfx_volume = get_node("Display/SFX")
onready var fullscreen = get_node("Display/Fullscreen")

func _ready():
    connect("_close_pressed", get_parent(), "_on_settings_close")

    music_volume.value = AudioServer.get_bus_volume_db(1) + 50
    sfx_volume.value = AudioServer.get_bus_volume_db(2) + 50

func _process(delta):
    AudioServer.set_bus_volume_db(1, music_volume.value - 50)

    AudioServer.set_bus_volume_db(2, sfx_volume.value - 50)


func _on_close_pressed():
	emit_signal("_close_pressed")
