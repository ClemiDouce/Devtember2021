extends Node2D

onready var progress := $ProgressBar

func setup(max_life, life):
	progress.max_value = max_life
	progress.value = life

func update_health(new_value):
	progress.value = new_value

func _process(_delta: float) -> void:
	self.global_rotation = 0
