extends KinematicBody2D
class_name Actor

export var speed := Vector2(100, 150)
export var gravity := 250

var _velocity := Vector2.ZERO	

func _physics_process(delta: float) -> void:
	self._velocity.y += gravity * delta

func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2
	) -> Vector2:
	var velocity: = linear_velocity
	velocity.x = speed.x * direction.x
	
	if direction.y != 0.0:
		velocity.y = speed.y * direction.y
	
	return velocity
