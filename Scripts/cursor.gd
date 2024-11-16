class_name Cursor
extends TextureRect

enum State {normal = 0, pick_up = 1, attack = 2, interact = 3}

@export var textures: Array[Texture2D];

func _ready() -> void:
	texture = textures[State.normal];

func set_cursor_state(state: State) -> void:
	texture = textures[state];
