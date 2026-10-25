extends CharacterBody2D


@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
var bobbleSpeed = 10
var bobbleAngle = 3
var speed = 250
var jumpVelocity = -375
var startingRotation : float

func _ready() -> void:
	startingRotation = sprite_2d.rotation
	

func jelly_bounce():
	velocity.y = -850

func mustard_launch():
	velocity.y = -650

func die():
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() :
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = jumpVelocity
	
	#Movement
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
		if is_on_floor():
			var offset = sin(Time.get_ticks_msec() / 50 * bobbleSpeed * deg_to_rad(bobbleAngle))
			sprite_2d.rotation = startingRotation + clamp(offset, deg_to_rad(-3), deg_to_rad(3))
		
	else:
		sprite_2d.rotation = move_toward(sprite_2d.rotation, 0, 10)
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()
	
	if not is_on_floor():
		if velocity.y > 0:
			sprite_2d.play("Falling")
		elif velocity.y < 0:
			sprite_2d.play("Fall Up")
	else:
		sprite_2d.play("Idle")
