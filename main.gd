class_name Main
extends Node2D

signal gameover
signal next_score(int)
signal next_hiscore(int)

signal game_state_changed(GameState)

@export var game_environment: GameEnvironment
@export var player: Player
@export var destroyer: StaticBody2D
@export var obstacle_spawner: ObstacleSpawner

@export var score_timer: Timer

enum GameState {
	WAITING_FOR_INPUT,
	PLAYING,
	PLAYER_DIED,
	RESTART
}

var hiscore: int = 0:
	set(next_value):
		hiscore = next_value
		next_hiscore.emit(hiscore)

var score: int = 0:
	set(next_value):
		score = next_value
		next_score.emit(score)

var _state: GameState = GameState.WAITING_FOR_INPUT:
	set(next_state):
		_state = next_state
		game_state_changed.emit(_state)
		match _state:
			GameState.WAITING_FOR_INPUT:
				_handle_waiting_for_input()
			GameState.PLAYING:
				_handle_game_start()
			GameState.PLAYER_DIED:
				_handle_player_died()
			GameState.RESTART:
				_handle_restart()

func _ready():
	assert(game_environment, "missing game environment")
	assert(player, "missing player")
	game_state_changed.emit(_state)
	_handle_waiting_for_input()


func _process(delta):
	match _state:
		GameState.WAITING_FOR_INPUT, GameState.RESTART:
			if Input.is_action_just_pressed("ui_accept"):
				_state = GameState.PLAYING


func _handle_waiting_for_input():
	game_environment.start_scrolling()

func _handle_game_start():
	score = 0
	game_environment.stop_scrolling()
	await player.enter()
	await get_tree().create_timer(1).timeout
	
	game_environment.start_scrolling()
	player.start_running()

	obstacle_spawner.start()
	score_timer.start()

func _handle_player_died():
	if score > hiscore:
		hiscore = score
	game_environment.stop_scrolling()
	player.die()
	obstacle_spawner.stop()
	score_timer.stop()
	gameover.emit()
	await get_tree().create_timer(2).timeout
	_state = GameState.RESTART

func _handle_restart():
	pass

func _handle_collide_with_player(obstacle):
	_state = GameState.PLAYER_DIED

func _on_score_timer_timeout():
	score += 1
