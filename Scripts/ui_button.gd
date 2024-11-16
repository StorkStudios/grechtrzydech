extends Button

var playback : AudioStreamPlaybackPolyphonic


func _ready() -> void:
	var stream = AudioStreamPolyphonic.new()
	stream.polyphony = 32
	$AudioStreamPlayer.stream = stream
	$AudioStreamPlayer.play()
	playback = $AudioStreamPlayer.get_stream_playback()
	

func _on_pressed() -> void:
	playback.play_stream(preload('res://Sounds/click1.wav'), 0, 0, randf_range(0.9, 1.1))
	
	
func _on_hoover() -> void:
	playback.play_stream(preload('res://Sounds/mouseclick1.wav'), 0, 0, randf_range(0.9, 1.1))
