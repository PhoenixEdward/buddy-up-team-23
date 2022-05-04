class_name AnimationArea
extends Area2D

export(String) var animation_name
export(NodePath) var animation_player_path

var _animation_player : AnimationPlayer

func _ready() -> void:
	connect("body_entered", self, "_on_body_entered")
	_animation_player = get_node(animation_player_path)
	
func _on_body_entered(body : Node) -> void:
	if body is Wheels:
		if body.velocity.dot(Vector2.RIGHT) > 0:
			_animation_player.play(animation_name)
		else:
			_animation_player.play(animation_name, -1, -1, true)
