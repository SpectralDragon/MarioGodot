extends Actor
class_name Enemy

export var score: = 100

enum Direction {
	LEFT = -1, RIGHT = 1
}

export(Direction) var direction_x = Direction.LEFT

func _ready() -> void:
	self.set_physics_process(false)
	$AnimationPlayer.play("movement")
	
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


func _on_StompArea_body_entered(body: Node) -> void:
	if body.name == "player":
		self.set_physics_process(false)
		self.die()

func die():
	Game.add_point(self.score)
	$AnimationPlayer.play("Die")
	yield($AnimationPlayer, "animation_finished")
	queue_free()
	


func _on_VisibilityNotifier2D_screen_entered() -> void:
	self.set_physics_process(true)
