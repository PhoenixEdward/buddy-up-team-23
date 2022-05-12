extends Label

export var animation_player_path : NodePath

onready var animation_player := get_node(animation_player_path) as AnimationPlayer

func _process(delta: float) -> void:
	if animation_player.current_animation != "":
		text = str(int(animation_player.current_animation_position))
