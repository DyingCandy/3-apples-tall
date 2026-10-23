extends CharacterBody2D


var speed = 20000
var jumpVelocity = -20000


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jumpVelocity * delta
	
	#Movement
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed * delta
	else:
		velocity.x = move_toward(velocity.x, 0, speed * delta)
	
	move_and_slide()
