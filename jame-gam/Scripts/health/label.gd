extends Label


@onready var health_component: HealthComponent = $"../../../HealthComponent"

func _ready() -> void:
	text = str(health_component.maxHealth)

func _on_health_component_health_changed(health: int, maxHealth: int) -> void:
	text = str(health)
	print("label received")
