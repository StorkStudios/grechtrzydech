class_name HubDoor;
extends Node3D;

@export var area: Area3D;
@export var anim_player: AnimationPlayer;
@export var game_scene = "res://Scenes/SpawnpointSelection.tscn"

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
	get_tree().change_scene_to_file(game_scene)
