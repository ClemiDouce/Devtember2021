extends Area2D

var is_visible = false
export (Vector2) var direction

onready var animation := $AnimationPlayer
onready var collision := $CollisionShape2D

func _process(delta: float) -> void:
	if self.visible:
		$Sprite.rotation += 1 * delta

func show():
	animation.play("appear")
	
func hide():
	animation.play_backwards("appear")

func get_spawn_position():
	return $PlayerSpawn.global_position


func _on_Portal_body_entered(body: KinematicBody2D) -> void:
	if body and self.visible:
		Event.emit_signal("player_changed_room", direction)
