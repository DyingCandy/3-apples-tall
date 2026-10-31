extends Area2D



@onready var health_component: HealthComponent = $HealthComponent







func _on_body_entered(body: Node2D) -> void:
		if body.name == ("Player"):
			print("apple collected")
			Global.applesCollected += 1
			body.add_heart(1)
			Global.nextLevel.start()
			queue_free()
