class_name HubDoor;
extends Node3D;

@export var area: Area3D;
@export var anim_player: AnimationPlayer;
@export var game_scene = "res://Scenes/SpawnpointSelection.tscn"

const black_duration: float = 1;

var mouse_inbounds: bool = false;

func _ready() -> void:
	area.mouse_entered.connect(on_mouse_entered);
	area.mouse_exited.connect(on_mouse_exited);

func on_mouse_entered() -> void:
	anim_player.play("Opening");
	mouse_inbounds = true;

func on_mouse_exited() -> void:
	anim_player.play("Closing");
	mouse_inbounds = false;

func _input(event: InputEvent) -> void:
	if (event is InputEventMouseButton && mouse_inbounds):
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			load_level();

func load_level() -> void:
	GlobalVariables.to_black(black_duration, on_to_black_ended);
	GlobalVariables.music.change_music(Music.MusicEnum.Level1, black_duration);

func on_to_black_ended() -> void:
	GlobalVariables.rooms = ["NrKey01", "NrKey11", "NrKey14", "NrKey22", "NrKey24"]
	get_tree().change_scene_to_file(game_scene);
	GlobalVariables.from_black(black_duration);
