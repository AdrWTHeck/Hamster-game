extends CharacterBody2D


var SPEED = 200
var direction = Vector2(-1,0)

const JUMP_VELOCITY = -400.0

var attacking = false


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")




func _ready():
	direction = -direction
	$AttackZone.connect("body_entered",_on_body_entered,CONNECT_PERSIST)
	$RayCast2D.enabled = true

	
func _on_body_entered(body):

	if body is CharacterBody2D:
		attacking = true
		$AttackZone.set_collision_layer_value(1,false)

func _physics_process(delta):
	if attacking == true:
		
		SPEED = 0
		await get_tree().create_timer(1).timeout

		SPEED = 600
		
		await get_tree().create_timer(1).timeout
		SPEED = 0
		await get_tree().create_timer(1).timeout
		SPEED = 200
		if SPEED == 200:
			attacking = false
			
			await get_tree().create_timer(5).timeout
			$AttackZone.set_collision_layer_value(1,true)
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if not $RayCast2D.is_colliding():
		direction = -direction
		$".".scale.x = -$".".scale.x
	velocity.x = direction.x * SPEED
	move_and_slide()
	
	
