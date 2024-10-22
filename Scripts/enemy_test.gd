extends CharacterBody2D


const SPEED = 200.0
var direction = Vector2(-1,0)

const JUMP_VELOCITY = -400.0


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _ready():
	$RayCast2D.enabled = true
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		$".".scale.x = -$".".scale.x
	if not $RayCast2D.is_colliding():
		direction = -direction
		$".".scale.x = -$".".scale.x
	velocity.x = direction.x * SPEED
	move_and_slide()
