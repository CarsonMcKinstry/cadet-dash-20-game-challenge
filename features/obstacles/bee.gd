extends Obstacle

@onready var _rng = RandomNumberGenerator.new()

func start( a_player: Player, a_destroyer: StaticBody2D, right_edge: int, y_level: int ):
	
	speed = _rng.randf_range(90.0, 125.0)
	
	player = a_player
	destroyer = a_destroyer
	
	var actual_y_level = _rng.randi_range(0, 96)
	
	position = Vector2(right_edge + sprite.get_rect().size.x / 2, actual_y_level)
	
	_state = ObstacleState.MOVING
