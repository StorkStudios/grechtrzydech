extends AudioStreamPlayer3D

@export var sounds : Array[AudioStream];

func _ready() -> void:
	stream = sounds[RandomNumberGenerator.new().randi_range(0, sounds.size() - 1)]
