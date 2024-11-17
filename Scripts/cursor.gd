class_name Cursor
extends TextureRect

enum State {normal = 0, pick_up = 1, attack = 2, interact = 3}

@export var textures: Array[Texture2D];
@export var compatible_img: TextureRect;

func _ready() -> void:
	texture = textures[State.normal];

func set_cursor_state(state: State, compatible: bool) -> void:
	texture = textures[state];
	compatible_img.visible = !compatible;
