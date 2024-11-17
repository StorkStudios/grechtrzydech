extends Node

var player_start_pos: Vector3

var mail_animation_state: int = 0;
var mails: Array[MailResource] = [];
var possible_rooms: Array[String] = ["NrKey01", "NrKey11", "NrKey12", "NrKey13", "NrKey14", "NrKey15", "NrKey21", "NrKey22", "NrKey23", "NrKey24"]
var rooms: Array[String] = []

@export var win_mail: MailResource;
@export var color_rect: ColorRect;
@export var music: Music;

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

func add_random_mail(mail_resources: Array[Resource]) -> void:
	var mails_left := mail_resources.filter(func(x): return mails.find(x) < 0);
	if (mails_left.size() > 0):
		mails.append(mails_left.pick_random());

func add_win_main():
	mails.append(win_mail);
