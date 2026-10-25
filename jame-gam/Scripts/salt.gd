extends StaticBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D

func shake():
	




func _on_salt_shake_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		shake()
