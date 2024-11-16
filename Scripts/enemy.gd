class_name Enemy
extends Node3D

@export var animation : EnemyAnimation;
var can_be_killed = true;


func get_killed() -> void:
	if (!can_be_killed):
		return;
	can_be_killed = false;
	get_tree().get_first_node_in_group("GameManager").npc_killed(self)
	animation.play_death_animation();
