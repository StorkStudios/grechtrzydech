extends Node

@export var world_map_corner: Vector3

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
	#top_left_corner.x += get_rect().size.x
	#top_left_corner.y += get_rect().size.y


func _process(delta: float) -> void:
	pass

func choose_spawnpoint():
	var map_pos = get_viewport().get_mouse_position()
	map_to_world_coordinates(map_pos-top_left_corner, selected_child.world_pos)
	
func map_to_world_coordinates(map: Vector2, world: Vector3):
	var res = world+Vector3(map.x, map.y, 0)
	var player: Node3D = get_tree().get_first_node_in_group("Players")
	print(res)
	if(player != null):
		player.position = res


func _on_button_left_button_down() -> void:
	change_visible_map((selected_level-1)%levels)
	
func _on_button_right_button_down() -> void:
	change_visible_map((selected_level+1)%levels)
	
func change_visible_map(new_level):
	selected_child.visible = false
	selected_level = new_level
	selected_child = $Maps.get_child(new_level)
	selected_child.visible = true
