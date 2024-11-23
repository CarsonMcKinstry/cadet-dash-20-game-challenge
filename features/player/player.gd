class_name Player
extends CharacterBody2D

const MAX_THRUST: int = 100

@export var floor: StaticBody2D
@export var ceiling: StaticBody2D
@export var particles: GPUParticles2D

@export var sprite: AnimatedSprite2D
@export var thrust: int = 30
@export var gravity: int = 10

enum PlayerState {
  RUNNING,
  FLYING,
  IDLE
}

var upward_velocity = 0

var _state = PlayerState.IDLE

func _ready():
	assert(sprite, "sprite missing")
	assert(floor, "floor missing")
	assert(ceiling, "ceiling missing")
	assert(particles, "particles missing")


func _process(_delta):
	match _state:
		PlayerState.IDLE:
			sprite.play("idle")
			sprite.speed_scale = 1
		PlayerState.FLYING:
			sprite.play("idle")
			sprite.speed_scale = 2
		PlayerState.RUNNING:
			sprite.speed_scale = 1
			sprite.play("run")

func _physics_process(delta):
	upward_velocity += gravity
	
	upward_velocity = clamp(upward_velocity, 0, MAX_THRUST)
	
	if Input.is_action_pressed("ui_accept"):
		upward_velocity -= thrust
		particles.emitting = true
	else:
		particles.emitting = false
	
	var result = move_and_collide(Vector2(0, upward_velocity) * delta)
	
	if result:
		if result.get_collider() == floor:
			_state = PlayerState.RUNNING
	else:
		_state = PlayerState.FLYING

func start_running():
	_state = PlayerState.RUNNING

func stop_running():
	_state = PlayerState.IDLE

func toggle_running():
	if _state == PlayerState.RUNNING:
		_state = PlayerState.IDLE
	else:
		_state = PlayerState.RUNNING