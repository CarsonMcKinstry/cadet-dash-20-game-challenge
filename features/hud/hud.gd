class_name Hud
extends Control

const SCORE_LABEL_LABEL: String = "Score: %s"
const HISCORE_LABEL_LABEL: String = "Hiscore: %s"

@export var world: Main

@export var score_label: Label
@export var hiscore_label: Label
@export var title_label: Label
@export var gameover_label: Label
@export var start_label: Label

func _ready():
	assert(world, "no world passed to the hud")
	assert(score_label, "no score label exists in the hud")

func _on_world_next_score(score: int):
	score_label.text = SCORE_LABEL_LABEL % str(score)

func _on_world_game_state_changed(game_state):
	match game_state:
		Main.GameState.WAITING_FOR_INPUT:
			_handle_waiting_for_input()
		Main.GameState.PLAYING:
			_handle_playing()
		Main.GameState.RESTART:
			_handle_restart()
		Main.GameState.PLAYER_DIED:
			_handle_player_died()


func _on_world_next_hiscore(score: int):
	hiscore_label.text = HISCORE_LABEL_LABEL % str(score)


func _handle_waiting_for_input():
	gameover_label.hide()
	start_label.show()
	title_label.show()
	score_label.show()

func _handle_playing():
	gameover_label.hide()
	start_label.hide()
	title_label.hide()
	score_label.show()

func _handle_player_died():
	gameover_label.show()
	start_label.hide()
	title_label.hide()
	score_label.show()

func _handle_restart():
	gameover_label.show()
	start_label.show()
	title_label.hide()
	score_label.show()
