extends KinematicBody2D
class_name PlayerBullet

var speed: int
var direction: Vector2
var velocity: Vector2

func init(vel:Vector2) -> PlayerBullet:
	self.velocity = vel

func _physics_process(delta: float) -> void:
	move_and_collide()
