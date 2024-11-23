class_name Obstacle
extends CharacterBody2D

@export var speed: float = 75.0
@export var player: Player
@export var destroyer: StaticBody2D

@export var sprite: Sprite2D

signal collide_with_player(Obstacle)

enum ObstacleState {
	MOVING,
	JUST_LOADED
}

var _state: ObstacleState = ObstacleState.JUST_LOADED

func _ready():
	assert(sprite, "missing sprite")

func _physics_process(delta):
	if _state == ObstacleState.MOVING:
		velocity = Vector2(-speed, 0)
	
		var result = move_and_collide(velocity * delta)
		
		if result:
			var collider = result.get_collider()
			match collider:
				player:
					collide_with_player.emit(self)
				destroyer:
					queue_free()

func start( a_player: Player, a_destroyer: StaticBody2D, right_edge: int, y_level: int ):
	player = a_player
	destroyer = a_destroyer
	
	position = Vector2(right_edge + sprite.get_rect().size.x / 2, y_level)
	
	_state = ObstacleState.MOVING
