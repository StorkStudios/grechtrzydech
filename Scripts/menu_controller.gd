extends Control

@export var game_scene = "res://Scenes/Hub.tscn"

func _ready() -> void:
	$VBoxContainer/StartGameButton.pressed.connect(_on_start_game_pressed)
	$VBoxContainer/CreditsButton.pressed.connect(_on_credits_button_pressed)
	$VBoxContainer/QuitGameButton.pressed.connect(_on_quit_game_pressed)


func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file(game_scene)


func _on_credits_button_pressed() -> void:
	$Credits.visible = !$Credits.visible


func _on_quit_game_pressed() -> void:
	get_tree().quit()
