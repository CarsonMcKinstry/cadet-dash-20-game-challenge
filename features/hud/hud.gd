class_name Hud
extends Control

const SCORE_LABEL_LABEL: String = "Score: %s"

@export var world: Main

@export var score_label: Label

func _ready():
	assert(world, "no world passed to the hud")
	assert(score_label, "no score label exists in the hud")

func _on_world_gameover():
	pass # Replace with function body.

func _on_world_next_score(int):
	score_label.text = SCORE_LABEL_LABEL % str(world.score)
