class_name Level
extends Node2D

export(Array, Resource) var dialogue_paths
export(int) var next_level = 0
var _processed_paths : PoolIntArray

func _ready() -> void:
	_processed_paths.resize(dialogue_paths.size())
	for i in range(_processed_paths.size()):
		_processed_paths[i] = 0
	if GameState.mobile_ui_enabled:
		$UILayer/MobileUI.show()
	else:
		$UILayer/MobileUI.hide()


func play_dialogue(path_index : int) -> void:
	if _processed_paths[path_index] == 0:
		DialogueManager.play_dialogue(dialogue_paths[path_index])
		_processed_paths[path_index] += 1

func load_next_level() -> void:
	get_tree().change_scene_to(GameState.levels[next_level])
