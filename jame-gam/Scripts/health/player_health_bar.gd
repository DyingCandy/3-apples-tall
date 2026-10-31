extends ProgressBar

@onready var health_component: HealthComponent = $"../../HealthComponent"



func _on_health_component_health_changed(health: int, maxHealth: int) -> void:
	max_value = maxHealth
	value = health
	print("health bar received")
