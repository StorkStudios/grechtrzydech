class_name Enemy
extends Node3D

func get_killed() -> void:
	get_tree().get_first_node_in_group("GameManager").npc_killed(self)
	self.queue_free()
