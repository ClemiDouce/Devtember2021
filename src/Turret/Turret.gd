extends StaticBody2D

export (bool) var detect = true
export (int) var max_life = 3
var life = max_life setget set_life
var target : KinematicBody2D = null

func _ready() -> void:
	target = owner.get_node_or_null('Player')
	print(target)
	
func _process(delta: float) -> void:
	if target != null:
		look_at(target.global_position)


func shoot():
	pass

func _on_Hitbox_area_entered(area: Area2D) -> void:
	area.owner.queue_free()
	self.life -= area.damage
	print('ouch')
	
func set_life(new_value: int):
	life = new_value
	if new_value <= 0:
		queue_free()
