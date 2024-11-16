extends Node

@export var enabled: bool
var bell_sound = preload("res://Sounds/Bell.mp3")
var audio_player: AudioStreamPlayer3D

func _ready() -> void:
	var player = get_tree().get_first_node_in_group("Players")
	audio_player = player.get_node("AudioStreamPlayer3D")
	audio_player.stream = bell_sound


func _on_clock_scene_kill_time_start() -> void:
	if (enabled):
		audio_player.play()
	else:
		print("bell")
