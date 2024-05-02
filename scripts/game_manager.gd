extends Node

@onready var coins = $Coins
@onready var game_hud = $GameHud

var score = 0

func add_point():
	score += 1
	coins.text = "You Collected " + str(score) + " Coins."
	game_hud.get_node("CC").text = "Score: " + str(score)

func quit_game():
	get_tree().quit()

func _input(event):
	if Input.is_action_just_pressed("Pause"):
		quit_game()
