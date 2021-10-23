class_name HealUp
extends "res://src/Powerup/BasePowerUp.gd"

export (int) var health_value = 1

func apply_effect(player: Player) -> void:
	player.life += health_value
