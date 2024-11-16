extends AnimationPlayer
class_name EnemyAnimation

signal death_animation_finished;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play("Idle")


func play_death_animation():
	play("Death")


func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Death":
		pause();
		death_animation_finished.emit();
