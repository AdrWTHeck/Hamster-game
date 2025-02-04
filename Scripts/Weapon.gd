extends Node

class_name Weapon

func weapon_change(weapon_name : String):
	if weapon_name == "Ball_Weapon":
		print("Using ball")
		$"../Direction_Switch/Node2D".visible = false
	
	if weapon_name == "Sword_weapon":
		$"../Direction_Switch/Node2D".visible = true
		print("Using sword")
