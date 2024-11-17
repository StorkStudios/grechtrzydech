extends Node3D

var clock: ClockScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	clock = get_tree().get_first_node_in_group("GameManager").get_node("ClockScene")

func _init() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var delta_time: float = clock.timer.wait_time - clock.timer.time_left if clock.is_kill_time else clock.timer.time_left
	var deltaMin = lerp(0, 360, delta_time)
	var deltaH = lerp(0, 360, delta_time/clock.timer.wait_time)
	$MinArrow.rotation_degrees = Vector3(deltaMin, 0, 0)
	$HArrow.rotation_degrees = Vector3(deltaH, 0, 0)
