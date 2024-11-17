extends Control

@export var game_scene = "res://Scenes/level.tscn"
@export var audioStream : AudioStream;
var levels
var selected_level
var top_left_corner
var selected_child: mapData

func _ready() -> void:
	levels = $Maps.get_child_count()
	selected_level = 0
	selected_child = $Maps.get_child(selected_level)
	selected_child.visible = true
	top_left_corner = selected_child.position
	play_sound()
	#top_left_corner.x += get_rect().size.x
	#top_left_corner.y += get_rect().size.y


func _process(delta: float) -> void:
	pass

func choose_spawnpoint():
	var map_pos = get_viewport().get_mouse_position()
	var width = selected_child.size.x
	map_to_world_coordinates(map_pos-top_left_corner, width)
	
func map_to_world_coordinates(map: Vector2, width: float):
	var mapx = map.x*selected_child.width/selected_child.scale.x/width
	var mapy = map.y*selected_child.width/selected_child.scale.y/width
	var res = selected_child.world_pos+Vector3(mapx, 0, mapy)
	print(mapx, " ", mapy, selected_child.world_pos, res)
	print(res)
	GlobalVariables.player_start_pos = res
	get_tree().change_scene_to_file(game_scene)

func _on_button_left_button_down() -> void:
	change_visible_map((selected_level-1)%levels)
	play_sound()
	
func _on_button_right_button_down() -> void:
	change_visible_map((selected_level+1)%levels)
	play_sound()
	
func change_visible_map(new_level):
	selected_child.visible = false
	selected_level = new_level
	selected_child = $Maps.get_child(new_level)
	selected_child.visible = true

func play_sound():
	$AudioStreamPlayer.stream = audioStream;
	$AudioStreamPlayer.play();
