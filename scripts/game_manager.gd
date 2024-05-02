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

func _ready():
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	
	# If the file didn't load, ignore it.
	if err != OK:
		config.save("user://settings.cfg")
	DisplayServer.window_set_mode(config.get_value("screen", "mode", 0))

func _input(_event):
	if Input.is_action_just_pressed("Pause"):
		quit_game()
	if Input.is_action_just_pressed("Fullscreen"):
		var config = ConfigFile.new()
		var err = config.load("user://settings.cfg")
		
		# If the file didn't load, ignore it.
		if err != OK:
			config.save("user://settings.cfg")
		var wind := DisplayServer.window_get_mode()
		if wind == 0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			config.set_value("screen", "mode", 3)
		elif wind == 3:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			config.set_value("screen", "mode", 0)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			config.set_value("screen", "mode", 0)
		config.save("user://settings.cfg")
