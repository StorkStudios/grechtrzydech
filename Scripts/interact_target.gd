class_name InteractTarget;
extends CollisionShape3D

@export var tag: String;
@export var allowMultipleInteractions: bool;

signal interacted;

var did_interact: bool = false;

func try_to_interact(item: Item) -> void:
	if (!allowMultipleInteractions && did_interact):
		return;
		
	if (!item || item.tag != tag):
		return;
	
	did_interact = true;
	interacted.emit();
	pass;

func _ready() -> void:
	did_interact = false;
	pass
