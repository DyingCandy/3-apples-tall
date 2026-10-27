extends Area2D

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var static_body_2d: CollisionShape2D = $Sprite2D/StaticBody2D/CollisionShape2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@export var jellypower : float = 1




func _on_sprite_2d_animation_finished() -> void:
	if sprite_2d.animation == "spring":
		sprite_2d.play("Idle")
		static_body_2d.scale.y = 1
		

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		sprite_2d.play("spring")
		print("playing")
		static_body_2d.scale.y /= 3
		body.jelly_bounce(jellypower)
		audio_stream_player_2d.play()
