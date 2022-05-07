class_name AirbornePlayerState
extends PlayerState

var buffer_frames_left : int = 0


func physics_update(delta : float) -> void:
	.physics_update(delta)
	if abs(_player.wheels.velocity.x) < _player.speed * _player.jump_steer:
		if Input.is_action_pressed("move_right"):
			_player.wheels.velocity.x = _player.speed * _player.jump_steer
		elif Input.is_action_pressed("move_left"):
			_player.wheels.velocity.x = -1 * _player.speed * _player.jump_steer


	if not _player.wheels.is_on_floor():
		_player.wheels.velocity.y = lerp(_player.wheels.velocity.y, _player.gravity, 0.05)
	else:
		state_machine.transition_to("Move")
		return

	if buffer_frames_left > 0:
		if _player.wheels.is_on_floor():
			_player.apply_jump_impulse()
			buffer_frames_left = 0
		else:
			buffer_frames_left -= 1
	elif Input.is_action_just_pressed("jump"):
		if _player.wheels.is_on_floor():
			_player.apply_jump_impulse()
		else:
			buffer_frames_left = 60
			
	_player.wheels.velocity = _player.wheels.move_and_slide(_player.wheels.velocity, Vector2.UP)
	
