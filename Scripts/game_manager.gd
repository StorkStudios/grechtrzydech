extends Node

enum game_state {kill_time, npc_killed, free}
var state = game_state.free

func _on_clock_scene_kill_time_end() -> void:
	if(state == game_state.npc_killed):
		state = game_state.free
	else:
		game_over()


func _on_clock_scene_kill_time_start() -> void:
	state = game_state.kill_time


func npc_killed(npc: Node) -> void:
	match state:
		game_state.free:
			game_over()
		game_state.npc_killed:
			game_over()
		game_state.kill_time:
			state = game_state.npc_killed
			print(npc.name + 'killed')

func game_over():
	print("GAME OVER!")
	await get_tree().create_timer(0.1).timeout
	#get_tree().quit()
	
