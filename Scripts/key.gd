extends Item

@export var key_num: String = "NrKey01"
@export var base_res_path = "res://Graphic/Materials/NrKey/"
var tres = ".tres"

func _ready() -> void:
	for child: MeshInstance3D in $Key.get_children():
		child.set_surface_override_material(0, load(base_res_path + key_num + tres))
