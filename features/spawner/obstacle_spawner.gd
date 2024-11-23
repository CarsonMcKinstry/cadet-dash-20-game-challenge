class_name ObstacleSpawner
extends Node2D

@export var world: Main
@export var timer: Timer

@export var spawn_chance: int = 50

@export var obstacles: Array[PackedScene]

@onready var _rng := RandomNumberGenerator.new()

const FLOOR_Y_LEVEL: int = 112

func _ready():
	assert(world, "no world found")

func _spawn_obstacle(scene: PackedScene):
	var obstacle: Obstacle = scene.instantiate()
	add_child(obstacle)
	
	obstacle.collide_with_player.connect(world._handle_collide_with_player, CONNECT_ONE_SHOT)
	
	obstacle.start(
		world.player,
		world.destroyer,
		get_viewport_rect().size.x,
		FLOOR_Y_LEVEL
	)

func start():
	timer.start()
	
func stop():
	timer.stop()

func _on_timer_timeout():
	var should_spawn = _check_if_should_spawn()
	
	if should_spawn:
		_spawn_obstacle(obstacles.pick_random())

func _check_if_should_spawn() -> bool:
	var r = _rng.randi_range(0, 100)
	
	return r < spawn_chance


func _on_world_gameover():
	for child in get_children():
		if child is Obstacle:
			child.queue_free()
