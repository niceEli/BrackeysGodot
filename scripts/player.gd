extends CharacterBody2D
class_name PlayerClass

@onready var animated_sprite = $AnimatedSprite2D
@onready var jump = $Jump
@onready var land = $Land

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var floored : int = 0

var coyote : int = 0

var jump_queue : int = 0

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Coyote Time
	if is_on_floor():
		coyote = 0
	else:
		coyote += 1
	
	# Jump Queue
	if Input.is_action_just_pressed("Jump"):
		jump_queue = 5
	else:
		jump_queue -= 1
	
	# Handle jump.
	if jump_queue >= 0 and coyote <= 10:
		velocity.y = JUMP_VELOCITY
		coyote = 11
		jump_queue = -1
		jump.play()
		
	if is_on_floor() && floored == 0:
		floored += 1
		land.play()
	else:
		if !is_on_floor():
			floored = 0
		
	# Get the input direction: -1, 0, 1
	var direction = Input.get_axis("MoveLeft", "MoveRight")
	
	# Flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else: 
		animated_sprite.play("jump")
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
