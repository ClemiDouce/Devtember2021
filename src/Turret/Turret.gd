extends StaticBody2D

const Bullet = preload("res://src/Bullet/TurretBullet/TurretBullet.tscn")

onready var muzzle := $Muzzle
onready var shoot_delay := $ShootDelay
onready var health_display = $HealthDisplay

export (bool) var detect = true
export (int) var max_life = 3
var life = max_life setget set_life
var target : KinematicBody2D = null

func _ready() -> void:
	target = owner.get_node_or_null('Player')
	if target:
		shoot_delay.wait_time = rand_range(1.0, 3.5)
		shoot_delay.start()
	
func _process(delta: float) -> void:
	if target != null:
		look_at(target.global_position)


func shoot():
	var bullet = Bullet.instance()
	owner.add_child(bullet)
	bullet.init(muzzle.global_transform, 300)

func _on_Hitbox_area_entered(area: Area2D) -> void:
	area.owner.queue_free()
	self.life -= area.damage
	
func set_life(new_value: int):
	life = new_value
	health_display.update_health(new_value)
	if new_value <= 0:
		queue_free()


func _on_ShootDelay_timeout() -> void:
	if target != null:
		shoot()
		shoot_delay.start()
