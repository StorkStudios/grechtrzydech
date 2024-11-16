extends Node

@export var enemy_number: int = 5
@export var enemy_scene = "res://Scenes/Enemy.tscn"

func _ready() -> void:
	var enemy_counter = 0
	var spawnpoints = get_tree().get_nodes_in_group("EnemySpawnpoint")
	spawnpoints.shuffle()
	for spawn: Node3D in spawnpoints:
		if(enemy_counter >= enemy_number):
			break
		var enemy: Enemy = load(enemy_scene).instantiate()
		spawn.add_child(enemy)
		enemy_counter += 1
