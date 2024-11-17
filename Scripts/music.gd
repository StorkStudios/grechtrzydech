class_name Music;
extends AudioStreamPlayer;

enum MusicEnum {Menu, Hub, Level1, Level2, Level3}

@export var menu_music: AudioStream;
@export var hub_music: AudioStream;
@export var level1_music: AudioStream;
@export var level2_music: AudioStream;
@export var level3_music: AudioStream;
@export var second_player: AudioStreamPlayer;
@export var music_volume: float;

var use_second_player: bool = true;
var is_changing_music: bool = false;

func _ready() -> void:
	stream = menu_music;
	play();
	volume_db = linear_to_db(music_volume);
	second_player.stop();
	second_player.volume_db = linear_to_db(0);

func change_music(type: MusicEnum, animation_duration: float):
	if (is_changing_music):
		return;
	is_changing_music = true;
	
	if (use_second_player):
		second_player.stream = get_music(type);
		second_player.play();
	else:
		stream = get_music(type);
		play();
	
	var time: float = 0;
	while (time < animation_duration):
		time += get_process_delta_time();
		var descending: float = linear_to_db(lerp(music_volume, 0.0, time / animation_duration));
		var rising: float = linear_to_db(lerp(0.0, music_volume, time / animation_duration));
		descending = 0 if is_nan(descending) else descending;
		rising = 0 if is_nan(rising) else rising;
		if (use_second_player):
			volume_db = descending;
			second_player.volume_db = rising;
		else:
			second_player.volume_db = descending;
			volume_db = rising;
		await get_tree().process_frame;
	
	if (use_second_player):
		stop();
	else:
		second_player.stop();
	
	use_second_player = !use_second_player;
	is_changing_music = false;

func get_music(type: MusicEnum):
	match (type):
		MusicEnum.Menu:
			return menu_music;
		MusicEnum.Hub:
			return hub_music;
		MusicEnum.Level1:
			return level1_music;
		MusicEnum.Level2:
			return level2_music;
		MusicEnum.Level3:
			return level3_music;
	return null;
