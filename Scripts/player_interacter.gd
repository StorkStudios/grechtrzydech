extends RayCast3D

@export var player_hand: PlayerHand;

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("interact")):
		interact();

func interact() -> void:
	var collider: Object = get_collider();
	print(collider);
	if (collider is Item):
		var item := collider as Item;
		player_hand.try_to_grab_item(item);
		
	elif (collider is InteractTarget):
		var interact_target := collider as InteractTarget;
		# todo
		
	elif (player_hand.held_item):
		player_hand.drop_item();
		
	
