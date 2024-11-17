extends AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_blend_time("Walking", "Iddle", 0.5)
	set_blend_time("Iddle", "Walking", 0.5)
	play("Iddle")
	

func _on_player_interacter_killed_enemy() -> void:
	play("MiddleFingers")
	queue("Walking")
	
	
func _on_player_walk_state_changed(state: Player.walking_state) -> void:
	if state == Player.walking_state.walk:
		play("Walking")
	else:
		play("Iddle")
