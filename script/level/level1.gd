class_name Level1
extends Level

var play_intro : bool

func _ready() -> void:
	if play_intro:
		$AnimationPlayer.play("Intro")
	else:
		pass
