extends KinematicBody2D
class_name Player

const Bullet = preload("res://src/Bullet/PlayerBullet/PlayerBullet.tscn")

onready var muzzle := $Muzzle
onready var health_display = $HealthDisplay
onready var shoot_rate := $ShootRate

export (int) var SPEED = 800
export (float) var FRICTION = 0.4
export (float) var ACCELERATION = 0.1
export (float) var SHOOT_SPEED = 0.7

var weapon_level = 1
var can_shoot = true

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
	
	if Input.is_action_pressed("shoot") and can_shoot:
		shoot()
		
func shoot() -> void:
	var bullet = Bullet.instance()
	get_tree().current_scene.add_child(bullet)
#	owner.add_child(bullet)
	bullet.init(muzzle.global_transform, 700)
	can_shoot = false
	shoot_rate.start()
	
func weapon_level_up():
	if weapon_level == 3:
		print("Can't go higher")
		return
	print("Weapon level up !")
	weapon_level += 1
	shoot_rate.wait_time -= 0.1

func _on_Hitbox_area_entered(bullet: Hurtbox) -> void:
	if not bullet:
		return
	Global.camera.shake(400, 0.3, 300)
	if bullet.owner.has_method('destroy'):
		bullet.owner.destroy()
	else:
		bullet.owner.queue_free()
	take_damage(1)

func take_damage(damage: int) -> void:
	PlayerStats.life -= damage
	health_display.update_health(PlayerStats.life)


func _on_ShootRate_timeout() -> void:
	can_shoot = true
