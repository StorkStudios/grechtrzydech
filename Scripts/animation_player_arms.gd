extends AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play("Walking")
	

func _on_player_interacter_killed_enemy() -> void:
	play("MiddleFingers")
	queue("Walking")
