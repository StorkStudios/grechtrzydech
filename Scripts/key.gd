extends Item

@export var base_res_path = "res://Graphic/Materials/NrKey/"
var tres = ".tres"

func _ready() -> void:
	
	for child: MeshInstance3D in find_children("", "MeshInstance3D"):
		child.set_surface_override_material(0, load(base_res_path + tag + tres))
