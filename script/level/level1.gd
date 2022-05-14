class_name Level1
extends Level

export var play_intro : bool

func _ready() -> void:
	if play_intro:
		$AnimationPlayer.play("Intro")
	else:
		pass
	if GameState.mobile_ui_enabled:
		$UILayer/MobileUI.show()
	else:
		$UILayer/MobileUI.hide()
