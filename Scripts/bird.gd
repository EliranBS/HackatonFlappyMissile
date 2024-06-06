extends CharacterBody2D

class_name Bird

signal game_started

@export var gravity = 900.0
@export var jump_force: int = -300
@onready var animation_player = $AnimationPlayer

var max_speed = 400
var rotation_speed = 0.2 # oren: it was 2

var is_started = false
var should_process_input = true

func _ready():
	velocity = Vector2.ZERO
	animation_player.play("idle")

func _physics_process(delta):
	if Input.is_action_just_pressed("jump") && should_process_input:
		if !is_started: 
			animation_player.play("flap_wings")
			game_started.emit()
			is_started = true
		jump()
		await get_tree().create_timer(0.35).timeout
		animation_player.play("flap_wings")
		
	if !is_started:
		animation_player.play("idle")
		return
	velocity.y += gravity * delta
	
	if velocity.y > max_speed:
		velocity.y = max_speed
	
	move_and_collide(velocity * delta)
	
	rotate_bird()
	
	
func jump():
	velocity.y = jump_force
	rotation = deg_to_rad(-5) #deg_to_rad(-30)
	animation_player.play("gas")
			

func rotate_bird():
	# Rotate downwards when falling
	if velocity.y > 0 and rad_to_deg(rotation) < 90:
		rotation += 10 * rotation_speed * deg_to_rad(1)
	# Rotate upwards when rising
	elif velocity.y < 0 and rad_to_deg(rotation) > -10:
		rotation -= rotation_speed * deg_to_rad(1)


func kill():
	should_process_input = false
	$explosion.play()
	
func stop():
	animation_player.stop()
	gravity = 0
	velocity = Vector2.ZERO
