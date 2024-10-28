extends CharacterBody2D

const JUMP_VELOCITY = -700.0
const FRICTION = 100.0  # Friction rate
const MAX_SPEED = 1200.0  # Maximum speed (4 times the initial speed)
const ACCELERATION_TIME = 5.0  # Time to reach MAX_SPEED in seconds

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var speed = 300.0  # Initial speed
var is_accelerating = false  # Flag to track acceleration
var acceleration_timer = 0.0  # Timer for acceleration

@onready var show_velocity = $ShowVelocity #This is the text edit box
@onready var enemy_test = $"../Enemy_test"



func _physics_process(delta):

	
	show_velocity.text = str(velocity.x) #Displays current velocity
	
	#Displays current velocity in output below when velocity.x is not showing 0
	if velocity.x != 0:
		print(velocity.x)
	
	
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

# !!! currently put as a comment to test a bug !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	# Get the input direction and handle movement/deceleration.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if Input.is_action_pressed("ui_left"):
		#$Sprite2D.scale.x = -1
	#if Input.is_action_pressed("ui_right"):
		#$Sprite2D.scale.x = 1
	
	# Makes the character start moving right
	var direction = Vector2(-1,0)
	
	# Makes the charcter turn around when the velocity.x shows 0.
	# This proves that you keep the speed when the velocity.x shows 0
	if show_velocity.text == "0":
		direction = -direction
	
	# Made direction into direction.x make sure to change this after done test bug
	 #Apply acceleration
	if direction.x != 0:
		if not is_accelerating:
			speed = 300.0  # Reset speed when starting acceleration
			is_accelerating = true
			acceleration_timer = 0.0  # Reset acceleration timer

	# Made direction into direction.x make sure to change this after done test bug
		velocity.x = direction.x * speed
		acceleration_timer += delta
		if acceleration_timer <= ACCELERATION_TIME:
			# Calculate speed increase based on time elapsed
			speed = 300.0 + (MAX_SPEED - 300.0) * (acceleration_timer / ACCELERATION_TIME)
		else:
			speed = MAX_SPEED # Cap speed at MAX_SPEED
		


	else:
		# Apply friction
		if is_accelerating:
			is_accelerating = false  # Stop acceleration
			velocity.x = direction/FRICTION

	move_and_slide()
