class_name Main
extends Node2D

signal gameover
signal next_score(int)

@export var game_environment: GameEnvironment
@export var player: Player
@export var destroyer: StaticBody2D
@export var obstacle_spawner: ObstacleSpawner

@export var score_timer: Timer

var score: int = 0

func _ready():
	assert(game_environment, "missing game environment")
	assert(player, "missing player")
	
	await player.enter()
	await get_tree().create_timer(1).timeout
	
	game_environment.toggle_scrolling()
	player.start_running()

	obstacle_spawner.start()
	score_timer.start()


func _handle_collide_with_player(obstacle):
	game_environment.stop_scrolling()
	player.die()
	obstacle_spawner.stop()
	score_timer.stop()
	gameover.emit()

func _on_score_timer_timeout():
	score += 1
	next_score.emit(score)
