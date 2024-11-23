class_name Main
extends Node2D

@export var game_environment: GameEnvironment
@export var player: Player

func _ready():
	assert(game_environment, "missing game environment")
	assert(player, "missing player")
	game_environment.toggle_scrolling()
	player.toggle_running()
