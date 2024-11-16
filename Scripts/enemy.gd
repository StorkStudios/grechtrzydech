class_name Enemy
extends Node

func get_killed() -> void:
	GameManager.npc_killed(self)
	self.queue_free()
