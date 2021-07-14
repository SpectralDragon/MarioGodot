extends Actor

enum Direction {
	LEFT = -1, RIGHT = 1
}

export(Direction) var direction_x = Direction.LEFT

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("Movement")
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	
	if direction_x == Direction.LEFT and is_on_wall():
		 self.direction_x = Direction.RIGHT	
	elif direction_x == Direction.RIGHT and is_on_wall():
		self.direction_x = Direction.LEFT
	
	if direction_x == Direction.LEFT:
		$Sprite.flip_h = false
	
	if direction_x == Direction.RIGHT:
		$Sprite.flip_h = true
	
	self._velocity = calculate_move_velocity(self._velocity, Vector2(direction_x, 0), speed)
	self._velocity = move_and_slide(self._velocity, Vector2.UP)
