extends Area2D

# The drag is a divider which controls the coin's acceleration and the time it
# takes to change direction. A higher value makes it less reactive.
const DRAG := 14.0
var max_speed := 600.0
var _friction := 0.1

var _velocity := Vector2.ZERO

func launch(pos: Vector2, vel: Vector2):
	print(pos, vel)
	self.global_position = pos
	_velocity = vel
	

func _physics_process(delta: float) -> void:
	# We detect attractors using `get_overlapping_areas()`
	var attractors := get_overlapping_areas()

	# If there is one or more overlapping areas, we steer towards the first one.
	if attractors:
		# The desired velocity is a vector of length `max_speed` pointing
		# towards the player.
		var desired_velocity: Vector2 = (
			(attractors[0].global_position - global_position).normalized()
			* max_speed
		)
		# The follow steering equation works like so:
		#
		# 1. We calculate the difference between the desired and current velocity.
		# 2. We add a fraction of that difference to the current velocity.
		var steering := desired_velocity - _velocity
		_velocity += steering / 14.0
	# In this basic example, we instantly stop the coin's movement if the
	# player gets too far.
	else:
		_velocity = lerp(_velocity, Vector2.ZERO, _friction)

	position += _velocity * delta


func _on_Coin_body_entered(body: Node) -> void:
	SoundManager.play_se("coin")	
	queue_free()
