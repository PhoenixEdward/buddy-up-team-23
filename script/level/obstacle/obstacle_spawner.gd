class_name ObstacleSpawner
extends Node2D

export var obstacle_scene : PackedScene
export var animation_player_path : NodePath

var obstacle : Node2D

func _ready() -> void:
	if get_children().size() == 0:
		obstacle = obstacle_scene.instance()
		if obstacle is AnimationArea:
			obstacle.animation_player_path = get_node(animation_player_path).get_path()
		add_child(obstacle)
	else:
		obstacle = get_child(0)
		if obstacle.position != Vector2.ZERO:
			position += obstacle.position
			obstacle.position = Vector2.ZERO
	EventManager.connect("player_died", self, "_on_player_died")


func _on_player_died() -> void:
	obstacle.queue_free()
	obstacle = obstacle_scene.instance()
	if obstacle is AnimationArea:
		obstacle.animation_player_path = get_node(animation_player_path).get_path()
	add_child(obstacle)
