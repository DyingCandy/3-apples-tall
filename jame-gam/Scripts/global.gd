extends Node

@onready var end: Timer = $End
var applesCollected : int = 0

func _process(delta: float) -> void:
	pass


func _on_end_timeout() -> void:
	#get_tree().change_scene_to_file("res://Scenes/Levels/level_" + str(int(get_tree().current_scene.name) + 1) + ".tscn")
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")
	print("level change")
