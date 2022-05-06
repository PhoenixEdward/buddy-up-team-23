class_name Collectable
extends AnimationArea


func _on_body_entered(body : Node) -> void:
	if animation_name != "":
		._on_body_entered(body)
	EventManager.emit_signal("item_collected")
	queue_free()
