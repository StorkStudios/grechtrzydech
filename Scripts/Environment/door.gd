extends Node3D

@export var animation_player: AnimationPlayer;
@export var interactTarget: InteractTarget;

var opened: bool = false;

func _init() -> void:
	interactTarget.interacted.connect(on_interacted);
	
func on_interacted() -> void:
	opened == !opened;
	animation_player.play("Opening" if opened else "Closing");
	
