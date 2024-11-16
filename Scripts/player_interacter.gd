extends RayCast3D

@export var player_hand: PlayerHand;
@export var cursor: Cursor;
@export var audioStreamPlayer: AudioStreamPlayer3D

var playback : AudioStreamPlaybackPolyphonic


func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("interact")):
		interact();
	if (Input.is_action_just_pressed("attack")):
		attack();
		
	cursor.set_cursor_state(Cursor.State.normal);
	
	var collider: Object = get_collider();
	if (collider is Item):
		cursor.set_cursor_state(Cursor.State.pick_up);
	elif (collider is InteractTarget):
		var interact_target := collider as InteractTarget;
		if (interact_target.will_interact(player_hand.held_item)):
			cursor.set_cursor_state(Cursor.State.interact);
	elif (collider is Enemy):
		cursor.set_cursor_state(Cursor.State.attack);

func interact() -> void:
	var collider: Object = get_collider();
	
	if (collider is Item):
		var item := collider as Item;
		player_hand.try_to_grab_item(item);
		if (item.pickupSound != null):
			audioStreamPlayer.stream = item.pickupSound;
			audioStreamPlayer.play();
		
	elif (collider is InteractTarget):
		var interact_target := collider as InteractTarget;
		interact_target.try_to_interact(player_hand.held_item);
		if (interact_target.interactSound != null):
			audioStreamPlayer.stream = interact_target.interactSound;
			audioStreamPlayer.play();
		
	elif (player_hand.held_item):
		player_hand.drop_item();
		
	

func attack() -> void:
	var collider: Object = get_collider();
	
	if (collider is Enemy):
		var enemy := collider as Enemy;
		enemy.get_killed();
