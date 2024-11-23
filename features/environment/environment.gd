class_name GameEnvironment
extends Node2D

@export var foreground_scrolling_speed: Vector2i = Vector2(66, 0)
@export var background_scrolling_speed: Vector2i = Vector2(33, 0)

@export var background: Parallax2D
@export var foreground: Parallax2D

enum EnvironmentState {
	SCROLLING,
	STATIONARY
}

var _state: EnvironmentState = EnvironmentState.STATIONARY

func _ready():
	assert(background, "missing background")
	assert(foreground, "missing foreground")

func _process(delta):
	match _state:
		EnvironmentState.SCROLLING:
			background.scroll_offset -= background_scrolling_speed * delta
			foreground.scroll_offset -= foreground_scrolling_speed * delta

func start_scrolling():
	_state = EnvironmentState.SCROLLING

func stop_scrolling():
	_state = EnvironmentState.STATIONARY

func toggle_scrolling():
	match _state:
		EnvironmentState.SCROLLING:
			stop_scrolling()
		EnvironmentState.STATIONARY:
			start_scrolling()
