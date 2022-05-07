class_name Wheels
extends KinematicBody2D

onready var sprite : Sprite = $Sprite
onready var particles : CPUParticles2D = $CPUParticles2D

var velocity : Vector2
var node_b : NodePath

#func _ready() -> void:
#	node_b = $PinJoint2D.node_b
#
#func detach_joint(detach := true) -> void:
#	if not detach:
#		$PinJoint2D.node_b = node_b
#	else:
#		$PinJoint2D.node_b = NodePath("")
