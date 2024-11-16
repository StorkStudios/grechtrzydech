extends Node

var bell_sound = preload("res://Sounds/Bell.mp3")

func _ready() -> void:
	get_parent().stream = bell_sound


func _on_clock_scene_kill_time_start() -> void:
	get_parent().play()
