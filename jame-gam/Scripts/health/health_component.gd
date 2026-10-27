extends Node
class_name HealthComponent

signal health_changed(health: int, maxHealth: int)
signal die

@export var maxHealth : float = 10
var health : float

func _ready() -> void:
	health = maxHealth

func takeDamage(amount : float) -> void:
	if amount <= 0:
		return
	
	health = clampf(health - amount, 0, maxHealth)
	health_changed.emit(health, maxHealth)
	
	if health <= 0:
		die.emit()

func heal(amount : float) -> void:
	if amount <= 0:
		return
	
	health = clampf(health + amount, 0, maxHealth)
	health_changed.emit(health, maxHealth)
