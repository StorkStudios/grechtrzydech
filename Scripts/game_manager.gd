extends Node
class_name GameManager

enum game_state {kill_time, npc_killed, free}
var state = game_state.free
var hub_scene = "res://Scenes/Hub.tscn"
var timeout = 2;
const black_duration: float = 1;
var is_game_over: bool = false;
var killed_counter = 0

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
			killed_counter += 1
			print(npc.name + 'killed')
			if( killed_counter >= $EnemySpawner.enemy_number):
				game_over()

func game_over():
	print("GAME OVER!")
	is_game_over = true;
	await get_tree().create_timer(timeout).timeout
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	GlobalVariables.to_black(black_duration, on_to_black_ended)

func on_to_black_ended() -> void:
	get_tree().change_scene_to_file(hub_scene)
	GlobalVariables.from_black(black_duration)
