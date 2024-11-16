extends Node3D

@export var interactionTag: String;
@export var animation_player: AnimationPlayer;
@export var interactTarget: InteractTarget;

var opened: bool = false;

func _ready() -> void:
	interactTarget.interacted.connect(on_interacted);
	interactTarget.tag = interactionTag;
	
func on_interacted() -> void:
	opened = !opened;
	animation_player.play("Opening" if opened else "Closing");
	
