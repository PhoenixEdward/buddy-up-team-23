class_name Player
extends Character

signal died()

export var respawn_point_path : NodePath
export(float, 1000, 2000) var boost : float = 1200
export var charge_gauge_offset : Vector2
export var gravity : float = 1200
export(int, 1,100) var boost_charge_rate : int = 1
export(int, 1,100) var boost_depletion_rate : int = 3
export(float,0,1) var acceleration : float = .1
export(float,0,1) var friction : float = .025
export(float, 100,2000) var max_jump_strength : float = 1800
export(float, 100,2000) var min_jump_strength : float = 600
export(float, 0, 1) var coyote_time = 0.2
export(float, 0, 1) var zelda_roll = 0.15
export(float, 0, 1) var jump_steer = 0.2
export var speed_boost_unlocked := true

var respawn := false


onready var wheels : Wheels = $Wheels
onready var player_body : RigidBody2D = $Body
onready var charge_gauge : TextureProgress = $UIlayer/ChargeGauge
onready var respawn_point : Position2D = get_node(respawn_point_path) as Position2D

func _ready() -> void:
	DialogueManager.player_dialogue_box = $UIlayer/DialogueBox
	$UIlayer/DialogueBox.speaker = self
	body = wheels
	facing = 1
	charge_gauge.value = charge_gauge.max_value



func change_respawn(path : NodePath) -> void:
	respawn_point = get_node(path)


func unlock_speed_boost() -> void:
	speed_boost_unlocked = true


func apply_jump_impulse() -> void:
	wheels.velocity += max_jump_strength * Vector2.UP + ((facing * Vector2.RIGHT) * wheels.velocity.x * zelda_roll)

func die() -> void:
	respawn = true
