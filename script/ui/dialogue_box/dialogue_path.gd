class_name DialoguePath
extends Resource

enum Speaker {
	NPC = 0,
	PLAYER = 1
}

export var is_choice : bool
export (Array, Speaker) var speakers : Array = []
export(Array, String) var speech : Array = []
export(Array, Resource) var next_paths : Array = []
