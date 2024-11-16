class_name Item;
extends RigidBody3D;

@export var tag: String;
@export var collider: CollisionShape3D;
@export var pickupSound: AudioStream;

func set_kinematic(kinematic: bool) -> void:
	freeze = kinematic;
	collider.disabled = kinematic;
