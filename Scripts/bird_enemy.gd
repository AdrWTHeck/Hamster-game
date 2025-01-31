extends CharacterBody2D

var SPEED = 200
var attacking = false
var direction = Vector2(-1,0)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	$Direction_Switch/AttackZone.connect("body_entered",_on_body_entered,CONNECT_PERSIST)
	$Direction_Switch/RayCast2D.enabled = true

	
func _on_body_entered(body):
	pass

func _physics_process(delta):
	if direction == Vector2(-1,0):
		$Direction_Switch.scale.x = -1
		
	if direction == Vector2(1,0):
		$Direction_Switch.scale.x = 1
	
	if $Direction_Switch/RayCast2D.is_colliding():
		direction = -direction
	

	velocity.x = direction.x * SPEED
	move_and_slide()
