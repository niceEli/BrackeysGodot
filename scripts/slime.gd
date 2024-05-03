extends Node2D
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D

const SPEED = 60

var direction = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding():
		animated_sprite.flip_h = false
		direction = 1
	
	position.x += direction * SPEED * delta


func _on_safe_space_body_entered(body: CharacterBody2D):
	body.velocity.y = body.JUMP_VELOCITY
	var sfx = body.get_node("Jump") as AudioStreamPlayer2D
	sfx.play()
	queue_free()
