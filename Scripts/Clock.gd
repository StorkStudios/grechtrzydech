extends Node
class_name clock

@export var time_between_kills: float = 1
@export var kill_time: float = 1
@export var isGameRunning: bool = true
signal kill_time_start
signal kill_time_end
func _ready() -> void:
	while isGameRunning:
		await clock()

func _process(delta: float) -> void:
	pass

func clock():
	await get_tree().create_timer(time_between_kills).timeout
	kill_time_start.emit()
	await get_tree().create_timer(kill_time).timeout
	kill_time_end.emit()
