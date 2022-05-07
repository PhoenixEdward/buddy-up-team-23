class_name PlayerBody
extends RigidBody2D

var reset := false
var _player : Player
var offset : Vector2

func _ready() -> void:
	yield(owner, "ready")
	_player = owner as Player
	assert(_player != null)
	offset = position

	
