class_name Level
extends Node2D

export(Array, Resource) var dialogue_paths
var _processed_paths : PoolIntArray

func _ready() -> void:
	_processed_paths.resize(dialogue_paths.size())
	for i in range(_processed_paths.size()):
		_processed_paths[i] = 0


func play_dialogue(path_index : int) -> void:
	if _processed_paths[path_index] == 0:
		DialogueManager.play_dialogue(dialogue_paths[path_index])
		_processed_paths[path_index] += 1

