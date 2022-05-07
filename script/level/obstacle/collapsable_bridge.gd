class_name CollapsableBridge
extends AnimationArea

export (float, 0, 2) var time_between_bricks = .15
export var reverse_collapse := false
export var collapsable := false

var _bricks := []
var _brick_index := 0
var _time_since_brick := 0.0
var _collapsing := false

class CustomSort:
	static func sort_by_global_x(a, b):
		return a.global_position.x < b.global_position.x

func _ready() -> void:
	for child in get_children():
		if child is RigidBody2D:
			_bricks.append(child)
			
	_bricks.sort_custom(CustomSort, "sort_by_global_x")
	if reverse_collapse:
		_bricks.invert()

func _physics_process(delta: float) -> void:
	if _collapsing:
		_time_since_brick += delta
		if _time_since_brick > time_between_bricks:
			if _brick_index < _bricks.size():
				_time_since_brick = 0
				_bricks[_brick_index].set_deferred("mode", RigidBody2D.MODE_RIGID)
				_bricks[_brick_index].apply_central_impulse(Vector2.DOWN * 9.8)
				_brick_index += 1
			else:
				_collapsing = false

func _on_body_entered(body : Node) -> void:
	if body is Wheels:
		if collapsable:
			_collapsing = true
