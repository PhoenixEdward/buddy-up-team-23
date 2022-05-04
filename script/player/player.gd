class_name Player
extends Node2D

export var _speed : float = 200.0

onready var _wheels : Wheels = $Wheels


func _ready() -> void:
	DialogueManager.player_dialogue_box = $Wheels/DialogueBox


func _physics_process(delta: float) -> void:
	var movement_vec := Vector2.ZERO
	
	if Input.is_action_pressed("ui_right"):
		movement_vec.x = 1
	elif Input.is_action_pressed("ui_left"):
		movement_vec.x = -1
	
	if not _wheels.is_on_floor():
		movement_vec += Vector2.DOWN * 9.8
		

	var collision := _wheels.get_last_slide_collision()
	var snap := Vector2.DOWN
	if collision != null:
		snap = collision.normal.rotated(PI)
		_wheels.sprite.rotation = collision.normal.rotated(PI/2.0).angle()
	_wheels.velocity = _wheels.move_and_slide_with_snap(movement_vec * _speed, snap, Vector2.UP, false, 24, 1, true)
	_wheels.particles.direction = _wheels.velocity.rotated(PI)
