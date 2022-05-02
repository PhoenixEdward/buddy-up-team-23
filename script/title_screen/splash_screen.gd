class_name SplashScreen
extends Control

const title_screen_scene : PackedScene = preload("res://scene/title_screen/TitleScreen.tscn")

onready var animation_player : AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("Splash")
	animation_player.connect("animation_finished", self, "_on_animation_finished")


func _on_animation_finished(animation : String) -> void:
	get_tree().change_scene_to(title_screen_scene)
