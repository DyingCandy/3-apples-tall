extends StaticBody2D

@onready var squirt: AudioStreamPlayer2D = $Squirt
@onready var mustard_explosion: CPUParticles2D = $MustardExplosion

func particle_emmit():
	mustard_explosion.emitting = true

func squirt_sound():
	squirt.play(0.6)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.mustard_launch()
		particle_emmit()
		squirt_sound()
		print("launch")
