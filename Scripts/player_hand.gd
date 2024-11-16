class_name PlayerHand
extends Node3D

@export var animation_duration: float;

var item_parent: Node = null;
var held_item: Item = null;

func try_to_grab_item(item: Item) -> void:
	if (held_item):
		return;
	
	held_item = item;
	held_item.set_kinematic(true);
	item_parent = held_item.get_parent();
	held_item.reparent(self);
	item_animation();

# korutyna 😎huj
func item_animation() -> void:
	var time: float = 0;
	var start_posiiton: Vector3 = held_item.position;
	while (held_item && time < animation_duration):
		time += get_process_delta_time();
		var t: float = time / animation_duration;
		held_item.position = start_posiiton.lerp(Vector3.ZERO, t);
		await get_tree().process_frame;

func drop_item() -> void:
	held_item.set_kinematic(false);
	held_item.reparent(item_parent);
	held_item = null;
	item_parent = null;
