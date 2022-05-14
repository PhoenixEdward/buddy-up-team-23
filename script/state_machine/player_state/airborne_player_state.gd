class_name AirbornePlayerState
extends PlayerState

var buffer_frames_left : int = 0
var _rng := RandomNumberGenerator.new()

func physics_update(delta : float) -> void:
	.physics_update(delta)
	var movement_vec := Vector2.ZERO
	
	if abs(_player.wheels.velocity.x) < _player.speed * _player.jump_steer:
		if Input.is_action_pressed("move_right"):
			_player.wheels.velocity.x = _player.speed * _player.jump_steer
		elif Input.is_action_pressed("move_left"):
			_player.wheels.velocity.x = -1 * _player.speed * _player.jump_steer
	
	if Input.is_action_pressed("move"):
		movement_vec = Vector2.ONE

	if movement_vec != Vector2.ZERO:
		if not _player.move_sound.playing:
			_player.move_sound.play(_rng.randf_range(0, _player.move_sound.stream.get_length()))
	else:
		if _player.move_sound.playing:
			_player.move_sound.stop()
			_player.stop_sound.play()
	
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
	
