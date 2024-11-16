class_name InteractTarget;
extends StaticBody3D;

@export var tag: String;
@export var allowMultipleInteractions: bool;

signal interacted;

var did_interact: bool = false;

func try_to_interact(item: Item) -> void:
	if (!will_interact(item)):
		return;
	
	did_interact = true;
	interacted.emit();

func will_interact(item: Item) -> bool:
	if (!allowMultipleInteractions && did_interact):
		return false;
		
	if (tag != "" && (!item || item.tag != tag)):
		return false;
		
	return true;

func _ready() -> void:
	did_interact = false;
