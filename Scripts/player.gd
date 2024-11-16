extends CharacterBody3D

# Movement properties
var move_speed = 5.0
var gravity = -9.8
var jump_speed = 10.0
var sensitivity_x = 0.01
var sensitivity_y = 0.5
var max_look_angle = 80.0

var mouse_delta = Vector2.ZERO
var jump_this_frame = false

# Movement vectors
var dir = Vector3.ZERO

# Vertical look angle
var vertical_look_angle = 0.0

func _ready() -> void:
	if(GlobalVariables.player_start_pos != null):
		get_parent_node_3d().position = GlobalVariables.player_start_pos
	

func _process(delta):
	handle_input()
	update_camera_rotation()

func _physics_process(delta):
	apply_gravity(delta)
	move_player(delta)

# Handle player input for movement
func handle_input():
	dir = Vector3.ZERO

	if Input.is_action_pressed("move_forward"):
		dir += transform.basis.z
	if Input.is_action_pressed("move_backward"):
		dir -= transform.basis.z
	if Input.is_action_pressed("move_left"):
		dir += transform.basis.x
	if Input.is_action_pressed("move_right"):
		dir -= transform.basis.x

	# Normalize dir to ensure consistent speed
	dir = dir.normalized()

	velocity.x = dir.x * move_speed
	velocity.z = dir.z * move_speed

# Update camera rotation based on mouse movement
func update_camera_rotation():
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		var rotation_x = -mouse_delta.y * sensitivity_y
		var rotation_y = -mouse_delta.x * sensitivity_x

		# Clamp vertical rotation to avoid flipping
		vertical_look_angle += rotation_x
		vertical_look_angle = clamp(vertical_look_angle, -max_look_angle, max_look_angle)

		# Apply horizontal rotation to the player
		rotate_y(rotation_y)

		# Apply vertical rotation to the camera
		$Camera3D.rotation_degrees.x = vertical_look_angle
		
		mouse_delta = Vector2.ZERO

# Apply gravity to the velocity
func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0  # Reset vertical velocity when on the ground

# Move the player based on input
func move_player(delta):
	# Move the character using CharacterBody3D's move_and_slide
	move_and_slide()


func _input(event):
	if event is InputEventMouseMotion:
		mouse_delta = event.relative
