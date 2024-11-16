extends RayCast3D

@export var player_hand: PlayerHand;
@export var cursor: Cursor;

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("interact")):
		interact();
	if (Input.is_action_just_pressed("attack")):
		attack();
		
	var collider: Object = get_collider();
	if (collider is Item):
		cursor.set_cursor_state(Cursor.State.pick_up);
	elif (collider is InteractTarget):
		cursor.set_cursor_state(Cursor.State.interact);
	elif (collider is Enemy):
		cursor.set_cursor_state(Cursor.State.attack);
	else:
		cursor.set_cursor_state(Cursor.State.normal);

func interact() -> void:
	var collider: Object = get_collider();
	
	if (collider is Item):
		var item := collider as Item;
		player_hand.try_to_grab_item(item);
		
	elif (collider is InteractTarget):
		var interact_target := collider as InteractTarget;
		interact_target.try_to_interact(player_hand.held_item);
		
	elif (player_hand.held_item):
		player_hand.drop_item();
		
	

func attack() -> void:
	var collider: Object = get_collider();
	
	if (collider is Enemy):
		var enemy := collider as Enemy;
		enemy.get_killed();
