extends Label

var clock: ClockScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	clock = get_tree().get_first_node_in_group("GameManager").get_node("ClockScene")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = str(snapped(clock.timer.time_left, 0.01))
