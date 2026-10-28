extends CharacterBody2D

var originalPos
var rightMax
var leftMax

func _ready() -> void:
	originalPos = global_position.x
	rightMax = originalPos + 100
	leftMax = originalPos - 100
	velocity.x = 200

func _physics_process(delta: float) -> void:
	if global_position.x >= rightMax:
		velocity.x = -100
	elif global_position.x <= leftMax:
		velocity.x = 100
	move_and_slide()


func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.hit(1)
		print("hit")
	
	
