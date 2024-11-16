class_name InteractTarget;
extends StaticBody3D;

@export var tag: String;
@export var allow_multiple_interactions: bool;
@export var interactSound: AudioStream;

signal interacted;

var did_interact: bool = false;
var override_interaction: bool = false;

func try_to_interact(item: Item) -> void:
	if (!will_interact(item)):
		return;
	
	did_interact = true;
	interacted.emit();

func will_interact(item: Item) -> bool:
	if (override_interaction):
		return true;
	
	if (!allow_multiple_interactions && did_interact):
		return false;
		
	if (tag != "" && (!item || item.tag != tag)):
		return false;
		
	return true;

func _ready() -> void:
	did_interact = false;
