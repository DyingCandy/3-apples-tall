extends ProgressBar

@onready var health_component: HealthComponent = $"../../HealthComponent"



func _on_health_component_health_changed(health: int, maxHealth: int) -> void:
	value = health
	max_value = maxHealth
	print("health bar received")
