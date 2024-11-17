extends Control

@export var game_scene = "res://Scenes/Hub.tscn"

func _ready() -> void:
	$Background/VBoxContainer/StartGameButton.pressed.connect(_on_start_game_pressed)
	$Background/VBoxContainer/CreditsButton.pressed.connect(_on_credits_button_pressed)
	$Credits/CreditsButton.pressed.connect(_on_credits_button_pressed)
	$Background/VBoxContainer/QuitGameButton.pressed.connect(_on_quit_game_pressed)


func _on_start_game_pressed() -> void:
	GlobalVariables.music.change_music(Music.MusicEnum.Hub, 0.1);
	get_tree().change_scene_to_file(game_scene)


func _on_credits_button_pressed() -> void:
	$Background.visible = $Credits.visible
	$Credits.visible = !$Background.visible

func _on_quit_game_pressed() -> void:
	get_tree().quit()
