extends Node

var tres = ".tres"
var base_res_path = "res://Graphic/Materials/"
var top_head = 2
var moustache = 2
var beard = 1
var glasses = 1
var accesories = 2
var accesories_string = "CharacterAccesories"
var eyes = 2
var eyes_string = "CharacterEyes"
var face = 2
var face_string = "CharacterFace"
var hair = 2
var hair_string = "CharacterHair"
var suit = 2
var suit_string = "CharacterSuit"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize_beard()
	randomize_glasses()
	randomize_moustache()
	randomize_top_head()
	randomize_accesories()
	randomize_eyes()
	randomize_face()
	randomize_hair()
	randomize_suit()

func randomize_enum_value(max: int, min = 0) -> int:
	return RandomNumberGenerator.new().randi_range(min, max)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func randomize_beard():
	var val = randomize_enum_value(beard)
	$Beard.visible = (val == 1)

func randomize_glasses():
	var val = randomize_enum_value(glasses)
	$Glasses.visible = (val == 1)

func randomize_top_head():
	var val = randomize_enum_value(top_head)
	$Cylinder.visible = (val == 1)
	$Hair.visible = (val == 2)

func randomize_moustache():
	var val = randomize_enum_value(moustache)
	$Moustache.visible = (val == 1)
	$MoustacheBeard.visible = (val == 2)

func randomize_accesories():
	var val = randomize_enum_value(accesories, 1)
	$Glasses.set_surface_override_material(0, load(base_res_path + accesories_string + str(val) + tres))
	$Cylinder.set_surface_override_material(0, load(base_res_path + accesories_string + str(val) + tres))

func randomize_eyes():
	var val = randomize_enum_value(eyes, 1)
	$EyeLeft.set_surface_override_material(0, load(base_res_path + eyes_string + str(val) + tres))
	$EyeRight.set_surface_override_material(0, load(base_res_path + eyes_string + str(val) + tres))
	
func randomize_face():
	var val = randomize_enum_value(face, 1)
	$Head.set_surface_override_material(0, load(base_res_path + face_string + str(val) + tres))
	$Hands.set_surface_override_material(0, load(base_res_path + face_string + str(val) + tres))

func randomize_hair():
	var val = randomize_enum_value(hair, 1)
	$Beard.set_surface_override_material(0, load(base_res_path + hair_string + str(val) + tres))
	$Eyebrows.set_surface_override_material(0, load(base_res_path + hair_string + str(val) + tres))
	$Hair.set_surface_override_material(0, load(base_res_path + hair_string + str(val) + tres))
	$Moustache.set_surface_override_material(0, load(base_res_path + hair_string + str(val) + tres))
	$MoustacheBeard.set_surface_override_material(0, load(base_res_path + hair_string + str(val) + tres))

func randomize_suit():
	var val = randomize_enum_value(suit, 1)
	$Suit.set_surface_override_material(0, load(base_res_path + suit_string + str(val) + tres))
