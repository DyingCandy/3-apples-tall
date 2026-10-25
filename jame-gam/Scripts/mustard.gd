extends StaticBody2D


@onready var mustard_explosion: CPUParticles2D = $MustardExplosion

func particle_emmit():
	mustard_explosion.emitting = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.mustard_launch()
		particle_emmit()
		print("launch")
