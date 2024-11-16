extends Node

var  top_head = 2
var  moustache = 2
var  beard = 1
var  glasses = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize_beard()
	randomize_glasses()
	randomize_moustache()
	randomize_top_head()

func randomize_enum_value(max: int) -> int:
	return RandomNumberGenerator.new().randi_range(0, max)
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
