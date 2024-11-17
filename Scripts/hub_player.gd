class_name HubPlayer;
extends Camera3D;

@export var look_angles: Vector2;

func _process(delta: float) -> void:
	var viewport: Viewport = get_viewport();
	var mouse_pos: Vector2 = viewport.get_mouse_position();
	var screen_size: Vector2 = viewport.get_visible_rect().size;
	var normalized_mouse_pos: Vector2 = Vector2.ONE - mouse_pos / screen_size;
	
	var x_rotation: float = lerp(-look_angles.x, look_angles.x, normalized_mouse_pos.y);
	var y_rotation: float = lerp(-look_angles.y, look_angles.y, normalized_mouse_pos.x);
	
	rotation_degrees.x = x_rotation;
	rotation_degrees.y = y_rotation;
