class_name Main
extends Node2D

@export var game_environment: GameEnvironment

func _ready():
  assert(game_environment, "missing game environment")

func _process(_delta):
  if Input.is_action_just_pressed("ui_accept"):
    game_environment.toggle_scrolling()