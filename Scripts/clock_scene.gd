extends Node
class_name ClockScene

@export var time_between_kills: float = 1
@export var kill_time: float = 1
@export var isGameRunning: bool = true
signal kill_time_start
signal kill_time_end
var timer: Timer
var is_kill_time = false

func _ready() -> void:
	timer = Timer.new()
	add_child(timer)
	while isGameRunning:
		await clock()

func _process(delta: float) -> void:
	pass

func clock():
	timer.start(time_between_kills)
	await timer.timeout
	is_kill_time = true
	kill_time_start.emit()
	timer.start(kill_time)
	await timer.timeout
	is_kill_time = false
	kill_time_end.emit()
