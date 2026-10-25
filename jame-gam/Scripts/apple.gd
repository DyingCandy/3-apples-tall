extends Area2D


@onready var player = $"../Player"


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		print("apple collected")
		Global.applesCollected += 1
		get_tree().change_scene_to_file("res://Scenes/Levels/level_2.tscn")
		Global.end.start()
