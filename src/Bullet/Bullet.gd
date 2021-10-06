extends KinematicBody2D

var speed = 0

func init(transform: Transform2D, speed: int):
	self.transform = transform
	self.speed = speed

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
