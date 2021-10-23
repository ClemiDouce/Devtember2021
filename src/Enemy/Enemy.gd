extends KinematicBody2D
class_name Enemy

signal enemy_died

const Coin = preload("res://src/Coin/Coin.tscn")

onready var health_display = $HealthDisplay

export (int) var max_life = 3
var life = max_life setget set_life

var target : KinematicBody2D = null

func _ready() -> void:
	health_display.setup(max_life, life)

func _physics_process(_delta: float) -> void:
	if target != null:
		attack_player()

func attack_player():
	pass

func activate(player: Player):
	self.target = player

func take_damage(bullet: Hurtbox, damages: int) -> void:
	bullet.owner.queue_free()
	self.life -= damages
	health_display.update_health(life)

func destroy():
	print("mort")
	emit_signal("enemy_died")
	drop_coins(4)
	queue_free()

func set_life(new_value):
	life = new_value
	if life <= 0:
		destroy()

func _on_Hitbox_area_entered(bullet: Hurtbox) -> void:
	if not bullet:
		return
	take_damage(bullet, bullet.damage)

func drop_coins(nbr: int) -> void:
	for i in range(nbr):
		var inst = Coin.instance()
		var rand_dir = rand_range(0,360)
		var direction := Vector2.RIGHT
		direction *= rand_range(400, 700)
		direction = direction.rotated(rand_dir)
		owner.add_child(inst)
		inst.launch(self.global_position, direction)
	
