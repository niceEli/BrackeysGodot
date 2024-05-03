extends Area2D

@onready var game_man = %GameManager
@onready var animation_player = $AnimationPlayer

func _on_body_entered(_body):
	game_man.add_point()
	animation_player.play("pickup")
