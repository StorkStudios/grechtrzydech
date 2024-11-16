extends Node

@export var enemy_number: int = 5
@export var enemy_scene = "res://Scenes/Enemy.tscn"

func _ready() -> void:
	var enemy_counter = 0
	var spawnpoints = get_tree().get_nodes_in_group("EnemySpawnpoint")
	print(spawnpoints.size())
	spawnpoints.shuffle()
	for spawn: Node3D in spawnpoints:
		if(enemy_counter >= enemy_number):
			break
		var enemy: Enemy = load(enemy_scene).instantiate()
		#enemy.position = spawn.position
		spawn.add_child(enemy)
		print(enemy.position)
		enemy_counter += 1
