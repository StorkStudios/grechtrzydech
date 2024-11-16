extends RayCast3D

@export var player_hand: PlayerHand;

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("interact")):
		interact();
	if (Input.is_action_just_pressed("attack")):
		attack();

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
	pass;
