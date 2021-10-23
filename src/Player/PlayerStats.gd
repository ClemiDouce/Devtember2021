extends Node

signal player_died

var max_life = 3
var life = max_life setget set_life
var weapon_level = 1


func set_life(new_value: int) -> void:
	life = new_value
	if life <= 0:
		emit_signal("player_died")
