class_name DeathArea
extends AnimationArea


func _on_body_entered(body : Node) -> void:
	if body is PlayerBody:
		body.get_parent().die()
		
	._on_body_entered(body)
