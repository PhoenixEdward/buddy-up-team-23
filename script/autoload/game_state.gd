extends Node

enum State {
	ROAMING,
	IN_DIALOGUE
}

const LEVEL1 = preload("res://scene/level/Level1.tscn")
const LEVEL2 = preload("res://scene/level/level2.tscn")
const LEVEL3 = preload("res://scene/level/level3.tscn")

var state : int
var mobile_ui_enabled := false

onready var levels := [LEVEL1, LEVEL2, LEVEL3]
