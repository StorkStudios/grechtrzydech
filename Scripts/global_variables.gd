extends Node

var player_start_pos: Vector3

var mail_animation_state: int = 0;
var mails: Array[Resource] = [];

@export var color_rect: ColorRect;

func to_black(duration: float, on_ended: Callable) -> void:
	var time: float = 0;
	color_rect.visible = true;
	while (time < duration):
		time += get_process_delta_time();
		color_rect.color.a = lerp(0, 1, time / duration);
		await get_tree().process_frame;
	color_rect.color.a = 1;
	on_ended.call();

func from_black(duration: float) -> void:
	var time: float = 0;
	while (time < duration):
		time += get_process_delta_time();
		color_rect.color.a = lerp(1, 0, time / duration);
		await get_tree().process_frame;
	color_rect.color.a = 0;
	color_rect.visible = false;
