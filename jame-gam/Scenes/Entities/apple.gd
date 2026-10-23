extends Area2D

@onready var player = $"../Player"

func _on_area_2d_area_entered(area: Area2D) -> void:
	print("apple collected")
	queue_free()
	player.scale *= 1.2
