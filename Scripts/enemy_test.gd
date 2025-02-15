extends CharacterBody2D

var SPEED = 200.0
var direction = Vector2(1,0)

const JUMP_VELOCITY = -400.0

@export var damage : int = 10

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _ready():
	$Direction_Switch/Kill_zone/CollisionShape2D.disabled = true
	$Direction_Switch/Attack_zone.connect("body_entered",_on_body_entered_attack,CONNECT_PERSIST)
	$Direction_Switch/Kill_zone.connect("body_entered",_on_body_entered_kill,CONNECT_PERSIST)
	$Direction_Switch/RayCastDown.enabled = true
	
func _on_body_entered_kill(body):
	if body.name == "Player_Character":
		print("hit")

func _on_body_entered_attack(body):
	if body.name == "Player_Character":
		$AnimationPlayer.play("attack")

func _speed_up():
	SPEED = 1000
	
func _speed_down():
	SPEED = 200


func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if not $Direction_Switch/RayCastDown.is_colliding():
		direction = -direction
		$Direction_Switch.scale.x = -$Direction_Switch.scale.x
	velocity.x = direction.x * SPEED
	move_and_slide()
