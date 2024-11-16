class_name DoormatController;
extends InteractTarget;

@export var local_position_target: Vector3;
@export var animation_duration: float;
@export var revealed_item: Item;
@export var item_position: Vector3;

func _init() -> void:
	interacted.connect(on_interacted);

func _ready() -> void:
	if (!revealed_item):
		return;
	
	revealed_item.set_kinematic(true);
	revealed_item.visible = false;
	revealed_item.global_position = to_global(item_position);

func will_interact(item: Item) -> bool:
	if (did_interact):
		return false;
	
	if (tag != "" && (!item || item.tag != tag)):
		return false;
	
	return true;

func on_interacted() -> void:
	doormat_animation();
	
	if (!revealed_item):
		return;
		
	revealed_item.set_kinematic(false);
	revealed_item.visible = true;
	
	
func doormat_animation() -> void:
	var time: float = 0;
	var start_posiiton: Vector3 = position;
	while (time < animation_duration):
		time += get_process_delta_time();
		var t: float = time / animation_duration;
		position = start_posiiton.lerp(start_posiiton + local_position_target, t);
		await get_tree().process_frame;
