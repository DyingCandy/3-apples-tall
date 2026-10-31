extends CharacterBody2D

#audios
@onready var hit_sound: AudioStreamPlayer2D = $Audios/Hit
@onready var death_sound: AudioStreamPlayer2D = $Audios/Death


@onready var death_explosion: CPUParticles2D = $"Death explosion"
@onready var health_component: HealthComponent = $HealthComponent
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var death_screen_timer: Timer = $"Death Screen Timer"

#Movement
var bobbleSpeed = 10
var bobbleAngle = 3
var speed = 250
var jumpVelocity = -375
var startingRotation : float
var can_move : bool = true

func add_heart(amount : int) -> void:
	health_component.maxHealth += amount
	health_component.health += amount
	health_component.health_changed.emit(health_component.health, health_component.maxHealth)
	print("heart added")
	print(health_component.maxHealth,  health_component.health)

func _ready() -> void:
	startingRotation = sprite_2d.rotation
	health_component.die.connect(on_death)
	can_move = true

func hit(damage_amount: float) -> void:
	health_component.takeDamage(damage_amount)
	
	hit_sound.play(0.5)
	print("hit recieved")
	print(damage_amount)

func on_death():
	death_explosion.emitting = true
	can_move = false
	sprite_2d.hide()
	death_sound.play(0.2)
	death_screen_timer.start()
	print("die")

func jelly_bounce(amount : float) -> void:
	velocity.y = -850 * amount

func mustard_launch():
	velocity.y = -650



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() :
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor() and can_move:
		velocity.y = jumpVelocity
	
	#Movement
	var direction := Input.get_axis("left", "right")
	if direction and can_move:
		velocity.x = direction * speed
		if is_on_floor():
			var offset = sin(Time.get_ticks_msec() / 50 * bobbleSpeed * deg_to_rad(bobbleAngle))
			sprite_2d.rotation = startingRotation + clamp(offset, deg_to_rad(-3), deg_to_rad(3))
		
	else:
		if is_on_floor():
			sprite_2d.rotation = move_toward(sprite_2d.rotation, 0, 10)
			velocity.x = move_toward(velocity.x, 0, speed)
		elif not is_on_floor():
			sprite_2d.rotation = move_toward(sprite_2d.rotation, 0, 10)
			velocity.x = move_toward(velocity.x, 0, 75)
	
	move_and_slide()
	
	if not is_on_floor():
		if velocity.y > 0:
			sprite_2d.play("Falling")
		elif velocity.y < 0:
			sprite_2d.play("Fall Up")
	else:
		sprite_2d.play("Idle")


func _on_death_screen_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/title_screen.tscn")
