extends CharacterBody2D

const JUMP_VELOCITY = -700.0
const FRICTION = 100.0  # Friction rate
const MAX_SPEED = 1200.0  # Maximum speed (4 times the initial speed)
const ACCELERATION_TIME = 5.0  # Time to reach MAX_SPEED in seconds
const PUSH_FORCE = 15.0
const MIN_PUSH_FORCE = 5.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var speed = 300.0  # Initial speed
var is_accelerating = false  # Flag to track acceleration
var acceleration_timer = 0.0  # Timer for acceleration
var direction = 0.0

var health_points = 3

@onready var text_box = $TextEdit #This is the text edit box
@onready var enemy_test = $"../Enemy_test"
@onready var animation = $AnimationPlayer

func _ready():
	$Direction_Switch/AttackZone.connect("body_entered",_on_body_entered,CONNECT_PERSIST)

func _on_body_entered(body):
	if body is CharacterBody2D:
		health_points -= 1

func _physics_process(delta):

	text_box.text = str(health_points) #Displays health_points variable
	
	#Displays current velocity in output below when velocity.x is not showing 0
	if velocity.x != 0:
		print(velocity.x)
	
	
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta + 1

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY


	# Get the input direction and handle movement/deceleration.
	direction = Input.get_axis("ui_left", "ui_right")
	if Input.is_action_pressed("ui_left"):
		$Direction_Switch.scale.x = -1
		animation.play("walk")
	if Input.is_action_pressed("ui_right"):
		$Direction_Switch.scale.x = 1
		animation.play("walk")
	if not is_accelerating:
		animation.play("idle right")
	if Input.is_action_pressed("ui_down"):
		animation.play("Player_Test_Attack")

	 #Apply acceleration
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
			speed = MAX_SPEED # Cap speed at MAX_SPEED
		


	else:
		# Apply friction
		if is_accelerating:
			is_accelerating = false  # Stop acceleration
			velocity.x = direction/FRICTION

	move_and_slide()
	
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			var push_force = (PUSH_FORCE*velocity.length() / MAX_SPEED) + MIN_PUSH_FORCE
			c.get_collider().apply_central_impulse(-c.get_normal()*push_force)

	
	
