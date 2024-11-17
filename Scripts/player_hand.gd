class_name PlayerHand
extends Node3D

@export var animation_duration: float;
@export var attachment: Node3D;

enum picking_state {pick, no_pick}

var item_parent: Node = null;
var held_item: Item = null;

signal picking_state_changed;

func try_to_grab_item(item: Item) -> void:
	if (held_item):
		return;
	
	held_item = item;
	held_item.set_kinematic(true);
	item_parent = held_item.get_parent();
	held_item.reparent(attachment);
	item_animation(item);
	picking_state_changed.emit(picking_state.pick)


# korutyna 😎chuj
func item_animation(item: Item) -> void:
	var time: float = 0;
	var start_posiiton: Vector3 = held_item.position;
	var start_rotation = Quaternion(held_item.transform.basis)
	var target_rotation = Quaternion()
	while (held_item && time < animation_duration):
		time += get_process_delta_time();
		var t: float = time / animation_duration;
		held_item.position = start_posiiton.lerp(Vector3.ZERO, t);
		held_item.transform.basis = Basis(start_rotation.slerp(target_rotation, t));
		await get_tree().process_frame;


func drop_item() -> void:
	held_item.set_kinematic(false);
	held_item.reparent(item_parent);
	held_item = null;
	item_parent = null;
	picking_state_changed.emit(picking_state.no_pick)
