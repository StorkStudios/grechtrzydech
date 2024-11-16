extends Node

func get_killed(delta: float) -> void:
	GameManager.npc_killed(self)
	self.queue_free()
