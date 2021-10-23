class_name Turret
extends Enemy

const Bullet = preload("res://src/Bullet/TurretBullet/TurretBullet.tscn")

onready var muzzle := $Muzzle
onready var shoot_delay := $ShootDelay

export (float) var rotation_speed = 0.1

func activate(player: Player):
	.activate(player)
	shoot_delay.wait_time = rand_range(1.0, 3.5)
	shoot_delay.start()

func attack_player():
	rotation = lerp_angle(rotation, rotation + get_angle_to(target.global_position), rotation_speed) 

func shoot():
	var bullet = Bullet.instance()
	owner.add_child(bullet)
	bullet.init(muzzle.global_transform, 300)

func _on_ShootDelay_timeout() -> void:
	if target != null:
		shoot()
		shoot_delay.start()
