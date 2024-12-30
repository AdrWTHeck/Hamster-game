#!!!!!!!The point of this code is to observe and understand the language and how ai solves any and all bugs we encounter


extends CharacterBody2D

const JUMP_VELOCITY = -700.0
const FRICTION = 5.0  # Further reduced friction for smoother sliding
const MAX_SPEED = 1200.0
const ACCELERATION_TIME = 5.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var speed = 300.0
var is_accelerating = false
var acceleration_timer = 0.0

@onready var show_velocity = $TextEdit



func _ready():
	pass
func _physics_process(delta):


	show_velocity.text = str(velocity.x)
	
	if velocity.x != 0:
		print(velocity.x)

	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		$Sprite2D.scale.x = direction

		if not is_accelerating:
			speed = 300.0
			is_accelerating = true
			acceleration_timer = 0.0

		acceleration_timer += delta
		speed = lerp(300.0, float(MAX_SPEED), acceleration_timer / ACCELERATION_TIME)
		speed = min(speed, float(MAX_SPEED))
		velocity.x = direction * speed
	else:
		if is_accelerating:
			is_accelerating = false
		# Apply friction smoothly without reversing direction
		if abs(velocity.x) > 0.1:
			velocity.x = move_toward(velocity.x,0.0, FRICTION)

		else:
			velocity.x = 0.0

	move_and_slide()
