class_name PowerUp
extends Area2D

func _ready() -> void:
	pass

func apply_effect(player: Player) -> void:
	pass

func _on_Powerup_body_entered(player: Player) -> void:
	apply_effect(player)
	self.queue_free()
