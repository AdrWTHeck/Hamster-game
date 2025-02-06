extends Node

class_name Damageable

@export var health : float = 30

func hit(damage : int):
	health -= damage
	print(health)
	
	if (health <= 0):
		get_parent().queue_free()
		
