extends Control


@export var menu_scene = "res://Scenes/MainMenu.tscn"
@export var game_manager: GameManager;

var paused = false

func _on_continue_game_pressed() -> void:
	unpause()
	visible = false


func _on_quit_game_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(menu_scene)
	
	
func _ready() -> void:
	visible = false


func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			if paused:
				unpause()
			else:
				pause()
	elif event is InputEventMouseButton:
		#capture mouse when window is selected
		if !paused && !game_manager.is_game_over:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
		
func pause():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	visible = true
	paused = true
	get_tree().paused = true
	
	
func unpause():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	visible = false
	paused = false
	get_tree().paused = false
