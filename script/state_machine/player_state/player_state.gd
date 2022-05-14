class_name PlayerState
extends State

var _player : Player

onready var current_gauge_offset : Vector2

func _ready() -> void:
	yield(owner, "ready")
	_player = owner as Player
	assert(_player != null)
	current_gauge_offset = _player.charge_gauge_offset * Vector2(-1, 1)


func physics_update(_delta:float) -> void:
	if _player.respawn:
		_player.player_body.global_position = _player.respawn_point.global_position + _player.player_body.offset
		_player.wheels.global_position = _player.respawn_point.global_position
		_player.wheels.velocity = Vector2.ZERO
		_player.player_body.reset = true
		_player.respawn = false
		EventManager.emit_signal("player_died")
	_player.wheels.sprite.rotate(((_player.wheels.velocity.x * _delta) / (_player.wheels.sprite.texture.get_size().x * PI)) * TAU)

func update(delta: float) -> void:
	if _player.facing > 0:
		current_gauge_offset = _player.charge_gauge_offset * Vector2(-1, 1)
	elif _player.facing < 0:
		current_gauge_offset = _player.charge_gauge_offset 

	if _player.charge_gauge.visible:
		_player.charge_gauge.rect_position = current_gauge_offset + _player.body.get_global_transform_with_canvas().origin


func _replenish_charge_gauge() -> void:
	if _player.charge_gauge.value < _player.charge_gauge.max_value:
		_player.charge_gauge.value += _player.boost_charge_rate
	elif _player.charge_gauge.visible:
		_player.charge_gauge.hide()
