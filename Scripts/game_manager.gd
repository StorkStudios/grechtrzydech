extends Node

enum game_state {kill_time, npc_killed, free}
var state = game_state.free
var hub_scene = "res://Scenes/Hub.tscn"
var timeout = 2;
const black_duration: float = 1;

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
	await get_tree().create_timer(timeout).timeout
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	GlobalVariables.to_black(black_duration, on_to_black_ended)

func on_to_black_ended() -> void:
	get_tree().change_scene_to_file(hub_scene)
	GlobalVariables.from_black(black_duration)
