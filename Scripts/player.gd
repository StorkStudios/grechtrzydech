extends CharacterBody3D

# Movement properties
var move_speed = 5.0
var gravity = -9.8
var jump_speed = 10.0
var sensitivity = 0.1
var max_look_angle = 80.0

var mouse_delta = Vector2.ZERO
var jump_this_frame = false

# Movement vectors
var dir = Vector3.ZERO

# Vertical look angle
var vertical_look_angle = 0.0

func _ready():
	# Capture the mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

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
		dir -= transform.basis.z
	if Input.is_action_pressed("move_backward"):
		dir += transform.basis.z
	if Input.is_action_pressed("move_left"):
		dir -= transform.basis.x
	if Input.is_action_pressed("move_right"):
		dir += transform.basis.x

	# Normalize dir to ensure consistent speed
	dir = dir.normalized()

	velocity.x = dir.x * move_speed
	velocity.z = dir.z * move_speed

# Update camera rotation based on mouse movement
func update_camera_rotation():
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		var mouse_motion = mouse_delta
		var rotation_x = -mouse_motion.y * sensitivity
		var rotation_y = -mouse_motion.x * sensitivity

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
	if is_on_floor() and jump_this_frame:
		velocity.y = jump_speed
		jump_this_frame = false

	# Move the character using CharacterBody3D's move_and_slide
	move_and_slide()

# Capture/uncapture the mouse with ESC
func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	elif event is InputEventMouseMotion:
		mouse_delta += event.position
