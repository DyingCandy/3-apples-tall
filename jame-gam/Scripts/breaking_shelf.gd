extends StaticBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var collision_shape_2d_area: CollisionShape2D = $Area2D/CollisionShape2D

@onready var shelfbreak_particles: CPUParticles2D = $"Shelfbreak particles"

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		animated_sprite_2d.play("Breaking")
		print("breaking")


func _on_animated_sprite_2d_animation_finished() -> void:
	shelfbreak_particles.emitting = true
	print("broken")
	animated_sprite_2d.hide()
	collision_shape_2d.disabled = true
	collision_shape_2d_area.disabled = true
