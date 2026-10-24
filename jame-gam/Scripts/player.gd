extends CharacterBody2D


var speed = 300
var jumpVelocity = -300


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = jumpVelocity
	
	#Movement
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()
