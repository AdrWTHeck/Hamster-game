extends Area2D

@onready var animation_player = $AnimationPlayer

func _ready():

	$CollisionShape2D.disabled = false
	$Sprite2D.visible = true
	$".".connect("body_entered",_on_body_entered,CONNECT_PERSIST)

func _on_body_entered(body):
	var name = $".".name
	if body.name == "Player_Character":
		animation_player.play("Pickup")
		for child in body.get_children():
			if child is Weapon:
				child.weapon_change(name)
