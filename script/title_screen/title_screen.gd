class_name TitleScreen
extends Control

var level_1_scene : PackedScene = preload("res://scene/level/Level1.tscn")

func _ready() -> void:
	$AnimationPlayer.play("EaseIn")
	$AnimationPlayer.connect("animation_finished", self, "_on_animation_finished")
	get_tree().paused = true


func _on_animation_finished(anim : String) -> void:
	get_tree().paused = false


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to(level_1_scene)


func _on_settings_button_pressed() -> void:
	if GameState.mobile_ui_enabled:
		GameState.mobile_ui_enabled = false
		$CenterContainer/VBoxContainer/SettingsButton.text = "Enable Mobile"
	else:
		GameState.mobile_ui_enabled  = true
		$CenterContainer/VBoxContainer/SettingsButton.text = "Disable Mobile"

