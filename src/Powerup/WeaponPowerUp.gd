class_name WeaponUp
extends "res://src/Powerup/BasePowerUp.gd"


func apply_effect(player: Player) -> void:
	player.weapon_level_up()
