extends KinematicBody2D

const Bullet = preload("res://src/Bullet/PlayerBullet/PlayerBullet.tscn")

onready var muzzle := $Muzzle
onready var health_display = $HealthDisplay

export (int) var SPEED = 800
export (float) var FRICTION = 0.4
export (float) var ACCELERATION = 0.1

export (int) var max_life = 3
var life = max_life setget set_life

var velocity = Vector2()

func get_input() -> Vector2:
	var input = Vector2()
	if Input.is_action_pressed("right"):
		input.x += 1
	if Input.is_action_pressed("left"):
		input.x -= 1
	if Input.is_action_pressed("up"):
		input.y -= 1
	if Input.is_action_pressed("down"):
		input.y += 1
	return input

func _physics_process(_delta: float) -> void:
	var direction : Vector2 = get_input()
	if direction.length() > 0:
		velocity = lerp(velocity, direction.normalized() * SPEED, ACCELERATION)
	else:
		velocity = lerp(velocity, Vector2.ZERO, FRICTION)
	velocity = move_and_slide(velocity)

func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("shoot"):
		shoot()
		
func shoot() -> void:
	var bullet = Bullet.instance()
	owner.add_child(bullet)
	bullet.init(muzzle.global_transform, 700)

func _on_Hitbox_area_entered(area: Area2D) -> void:
	Global.camera.shake(400, 0.3, 300)
	area.owner.queue_free()
	self.life -= 1

func set_life(new_value):
	life = new_value
	health_display.update_health(new_value)
