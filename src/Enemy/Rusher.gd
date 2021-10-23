class_name Rusher
extends Enemy

var speed = 200


func attack_player():
	look_at(target.global_position)
	var velocity = self.position.direction_to(target.position) * speed
	var slide = move_and_slide(velocity)
