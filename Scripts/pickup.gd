extends Area2D

@onready var animation_player = $AnimationPlayer

func _ready():

	$CollisionShape2D.disabled = false
	$Sprite2D.visible = true
	$".".connect("body_entered",_on_body_entered,CONNECT_PERSIST)

func _on_body_entered(body):

	if body.name == "Player_Character":
		animation_player.play("Pickup")
		
