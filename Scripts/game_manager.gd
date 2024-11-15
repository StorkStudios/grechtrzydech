extends Node

enum game_state {kill_time, npc_killed, free}
var state = game_state.free

func _on_clock_scene_kill_time_end() -> void:
	if(state == game_state.npc_killed):
		state = game_state.free
	else:
		print("YOU LOST!")


func _on_clock_scene_kill_time_start() -> void:
	state = game_state.kill_time


func npc_killed(npc: Node) -> void:
	if(state == game_state.kill_time):
		state = game_state.npc_killed
		print(npc.name + 'killed')
