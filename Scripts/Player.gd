class_name Player
extends Actor

export var stomp_impulse: = 90.0

export var is_big = false

enum AnimationState { MOVEMENT, JUMP, IDLE, DIE }

func _physics_process(delta: float) -> void:
	var direction = self.get_direction()
	update_animation(direction)
	
	self._velocity = self.calculate_move_velocity(self._velocity, direction, self.speed)
	self._velocity = move_and_slide(self._velocity, Vector2.UP)


func get_direction() -> Vector2:
	var direction = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		-1.0 if is_on_floor() and Input.is_action_just_pressed("jump") else 0.0
	)
	
	return direction
	
func calculate_stomp_velocity(linear_velocity: Vector2, stomp_impulse: float) -> Vector2:
	var stomp_jump: = -speed.y if Input.is_action_pressed("jump") else -stomp_impulse
	return Vector2(linear_velocity.x, stomp_jump)

func update_animation(direction: Vector2):
	if direction.x < 0:
		set_animation_state(AnimationState.MOVEMENT)
		$Sprite.flip_h = true
		
	if direction.x > 0:
		set_animation_state(AnimationState.MOVEMENT)
		$Sprite.flip_h = false
	
	if direction.x == 0:
		set_animation_state(AnimationState.IDLE)
		
	if not is_on_floor():
		set_animation_state(AnimationState.JUMP)	
	
func set_animation_state(state):
	if state == AnimationState.MOVEMENT:
		$AnimationPlayer.play("Movement")
	elif state == AnimationState.JUMP:
		$AnimationPlayer.play("Jump")
	elif state == AnimationState.DIE:
		$AnimationPlayer.play("Die")
	else:
		$AnimationPlayer.play("Idle")

func is_player_big() -> bool:
	return self.is_big

func _on_Area2D_body_entered(body: Node) -> void:
	if body.name == "enemy":
		self._velocity = calculate_stomp_velocity(self._velocity, self.stomp_impulse)

func die():
	self.set_physics_process(false)
	self.set_animation_state(AnimationState.DIE)
	yield($AnimationPlayer, "animation_finished")
	
	queue_free()
	Game.restart()
