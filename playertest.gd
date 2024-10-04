extends CharacterBody2D

const JUMP_VELOCITY = -400.0
const FRICTION = 100.0  # Friction rate
const MAX_SPEED = 1200.0  # Maximum speed (2 times the initial speed)
const ACCELERATION_TIME = 5.0  # Time to reach MAX_SPEED in seconds

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var speed = 300.0  # Initial speed
var is_accelerating = false  # Flag to track acceleration
var acceleration_timer = 0.0  # Timer for acceleration

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle movement/deceleration.
	var direction = Input.get_axis("ui_left", "ui_right")

	# Apply acceleration
	if direction != 0:
		if not is_accelerating:
			speed = 300.0  # Reset speed when starting acceleration
			is_accelerating = true
			acceleration_timer = 0.0  # Reset acceleration timer

		velocity.x = direction * speed
		acceleration_timer += delta
		if acceleration_timer <= ACCELERATION_TIME:
			# Calculate speed increase based on time elapsed
			speed = 300.0 + (MAX_SPEED - 300.0) * (acceleration_timer / ACCELERATION_TIME)
		else:
			speed = MAX_SPEED  # Cap speed at MAX_SPEED

	else:
		# Apply friction
		if is_accelerating:
			is_accelerating = false  # Stop acceleration
			velocity.x = direction/FRICTION

	move_and_slide()
