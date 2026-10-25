extends PointLight2D

func _process(delta: float) -> void:
	if energy <= 2:
		energy = move_toward(energy, 4, 5)
	elif energy >= 4:
		energy = move_toward(energy, 2, 5)
