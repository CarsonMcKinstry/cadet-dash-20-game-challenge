class_name GameEnvironment
extends Node2D

@export var foreground_scroll_speed: Vector2i = Vector2i(100, 0)
@export var background_scroll_speed: Vector2i = Vector2i(150, 0)

@export var background: Parallax2D
@export var foreground: Parallax2D

enum EnvironmentState {
  SCROLLING,
  STATIONARY
}

var _state: EnvironmentState = EnvironmentState.STATIONARY

func _ready():
  _verify_dependencies()

func _process(delta):
  if _state == EnvironmentState.SCROLLING:
    background.scroll_offset -= delta * background_scroll_speed
    foreground.scroll_offset -= delta * foreground_scroll_speed

func start_scrolling():
  _state = EnvironmentState.SCROLLING

func stop_scrolling():
  _state = EnvironmentState.STATIONARY

func toggle_scrolling():
  if _state == EnvironmentState.STATIONARY:
    _state = EnvironmentState.SCROLLING
  else:
    _state = EnvironmentState.STATIONARY

func _verify_dependencies():
  assert(background, "background missing")
  assert(foreground, "foreground missing")