extends CharacterBody2D



const SPEED = 200.0
var direction = Vector2(1,0)

const JUMP_VELOCITY = -400.0


var health_points = 5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _ready():
	$Direction_Switch/RayCastDown.enabled = true
	
func _physics_process(delta):
	$TextEdit.text = str(health_points)
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		$Direction_Switch.scale.x = -$Direction_Switch.scale.x
	if not $Direction_Switch/RayCastDown.is_colliding():
		direction = -direction
		$Direction_Switch.scale.x = -$Direction_Switch.scale.x
	velocity.x = direction.x * SPEED
	move_and_slide()
