class_name Item;
extends RigidBody3D;

@export var tag: String;
@export var collider: CollisionShape3D;

func set_kinematic(kinematic: bool) -> void:
	freeze = kinematic;
	collider.disabled = kinematic;
