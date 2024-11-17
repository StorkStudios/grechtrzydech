extends TextureButton
class_name mapData

@export var world_pos: Vector3
@export var width: float = 10

func _ready() -> void:
	size.x = get_viewport_rect().size.y/scale.y
	size.y = get_viewport_rect().size.y/scale.y
	
