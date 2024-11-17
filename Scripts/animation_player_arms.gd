extends AnimationPlayer

var walking_state: Player.walking_state = Player.walking_state.idle;
var picking_state: PlayerHand.picking_state = PlayerHand.picking_state.no_pick;

var animations: Array[String] = ["Walking", "Iddle", "MiddleFinger", "WalkingWithPicking", "IdleWithPicking"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(animations.size()):
		for j in range(i, animations.size() - 1):
			set_blend_time(animations[i], animations[j], 0.5)
			set_blend_time(animations[j], animations[i], 0.5)
	play("Iddle")
	

func _on_player_interacter_killed_enemy() -> void:
	play("KillingBetter")
	
	
func _on_player_walk_state_changed(state: Player.walking_state) -> void:
	walking_state = state;
	update_animation();


func _on_animation_finished(anim_name: StringName) -> void:
	#print("Finished " + anim_name)
	if (anim_name == "MiddleFinger" ||
	anim_name == "KillingBetter" ||
	anim_name == "Picking"):
		update_animation();


func update_animation():
	if walking_state == Player.walking_state.walk:
		play("Walking" if picking_state == PlayerHand.picking_state.no_pick else "WalkingWithPicking")
	else:
		play("Iddle" if picking_state == PlayerHand.picking_state.no_pick else "IdleWithPicking")


func _on_player_interacter_middle_finger() -> void:
	play("MiddleFinger")


func _on_player_hand_picking_state_changed(state: PlayerHand.picking_state) -> void:
	picking_state = state;
	if (state == PlayerHand.picking_state.pick):
		play("Picking");
	else:
		update_animation();
