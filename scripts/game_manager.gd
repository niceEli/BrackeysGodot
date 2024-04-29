extends Node

@onready var coins = $Coins

var score = 0

func add_point():
	score += 1
	coins.text = "You Collected " + str(score) + " Coins."
