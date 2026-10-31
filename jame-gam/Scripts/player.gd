extends CharacterBody2D

#audios
@onready var hit_sound: AudioStreamPlayer2D = $Audios/Hit
@onready var death_sound: AudioStreamPlayer2D = $Audios/Death

@onready var marker_2d: Marker2D = $"../Marker2D"


@onready var death_explosion: CPUParticles2D = $"Death explosion"
@onready var health_component: HealthComponent = $HealthComponent
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var death_screen_timer: Timer = $"Death Screen Timer"
@onready var dash_timer: Timer = $"Dash timer"
@onready var dash_again_timer: Timer = $"Dash timer/Dash again timer"
#Movement
var bobbleSpeed = 10
var bobbleAngle = 3
var speed = 200
var jumpVelocity = -375
var startingRotation : float
var can_move : bool = true
var can_dash : bool = false
var dashspeed = 500
var dashing : bool = false
var dashcooldown : bool = false
var left : bool
var right : bool

func add_heart(amount : int) -> void:
	health_component.maxHealth += amount
	health_component.health += amount
	health_component.health_changed.emit(health_component.health, health_component.maxHealth)
	print("heart added")
	print(health_component.maxHealth,  health_component.health)
	Global.maxPlayerHealth = health_component.maxHealth

func _ready() -> void:
	startingRotation = sprite_2d.rotation
	health_component.die.connect(on_death)
	can_move = true
	sprite_2d.show()

func hit(damage_amount: float) -> void:
	health_component.takeDamage(damage_amount)
	if velocity.y > 0 :
		velocity.y = -350
	elif velocity.y < 0:
		velocity.y = 100
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
	velocity.y = -900 * amount

func mustard_launch():
	velocity.y = -700



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() :
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor() and can_move:
		velocity.y = jumpVelocity
	
	#Dash
	if Input.is_action_just_pressed("dash") and can_dash and dashcooldown == false:
		dashing = true
		dash_timer.start()
		dash_again_timer.start()
	
	
	#Movement
	var direction := Input.get_axis("left", "right")
	if direction and can_move:
		if dashing == true:
			velocity.x = direction * dashspeed
		else:
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
	#global_position = marker_2d.global_position
	#can_move = true
	#sprite_2d.show()
	get_tree().reload_current_scene()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		can_dash = true


func _on_dash_timer_timeout() -> void:
	dashing = false
	dashcooldown = true


func _on_dash_again_timer_timeout() -> void:
	dashcooldown = false
