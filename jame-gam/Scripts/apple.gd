extends Area2D

@onready var nextLevelTimer = $"Next level"
@onready var player = $"../Player"

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		print("apple collected")
		Global.applesCollected += 1
		nextLevelTimer.start()
		


func _on_next_level_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/level_" + str(int(get_tree().current_scene.name) + 1) + ".tscn")
	print("level change")
