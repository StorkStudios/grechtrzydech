extends Control

@export var game_scene = "res://Scenes/node_3d.tscn"

func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file(game_scene)


func _on_credits_button_pressed() -> void:
	$Credits.visible = !$Credits.visible


func _on_quit_game_pressed() -> void:
	get_tree().quit()
