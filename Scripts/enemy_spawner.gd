extends Node

@export var enemy_scene = "res://Scenes/Enemy.tscn"

func _ready() -> void:
	var spawnpoints = get_tree().get_nodes_in_group("EnemySpawnpoint")
	for spawn: EnemySpawnpoint in spawnpoints:
		if(GlobalVariables.rooms.find(spawn.key_code) != -1):
			var enemy: Enemy = load(enemy_scene).instantiate()
			spawn.add_child(enemy)
