extends KinematicBody2D

const Bullet = preload("res://src/Bullet/PlayerBullet/PlayerBullet.tscn")

onready var muzzle := $Muzzle

export var SPEED = 800
export var FRICTION = 0.4
export var ACCELERATION = 0.1

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
	bullet.transform = muzzle.global_transform
	
