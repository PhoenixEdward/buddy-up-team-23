extends Label


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var count := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_AnimationPlayer_animation_started(anim_name: String) -> void:
	text = anim_name
