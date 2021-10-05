extends KinematicBody2D

#var velocity: Vector2
var SPEED = 750

#func init(muzzle):
#	self.velocity = dir * speed
#	self.position = pos
#	return self

func _physics_process(delta: float) -> void:
	position += transform.x * SPEED * delta
