class_name DialogueBox
extends Control

const TIME_PER_CHAR := 0.5

export var rect_max_size : Vector2

var _time_since_char := 0.0
var _speaking_offset : Vector2
var speaker : Character

onready var _right_speaking_offset : Position2D = $RightSpeakingOffset
onready var _left_speaking_offset : Position2D = $LeftSpeakingOffset

onready var _dialogue : Label = $Background/MarginContainer/Dialogue
onready var _right_choice : TextureRect = $Background/RightChoice
onready var _left_choice : TextureRect = $Background/LeftChoice

func _ready() -> void:
	hide()


func _process(delta: float) -> void:
	if visible:
		if _dialogue.visible_characters < _dialogue.text.length():
			_time_since_char += delta
			if _time_since_char >= TIME_PER_CHAR:
				_dialogue.visible_characters += 1
#	if get_tree().get_nodes_in_group("camera").size() > 0:
#		rect_scale = get_tree().get_nodes_in_group("camera")[0].zoom
	if speaker.body.get_global_transform_with_canvas().origin.x > get_viewport().size.x / 2.0:
		_speaking_offset = _left_speaking_offset.position
	else:
		_speaking_offset = _right_speaking_offset.position
		
	rect_position = Vector2(speaker.body.get_global_transform_with_canvas().origin.x, 128)

func speak(speech : String, face_right : bool,
left_choice := false, right_choice := false) -> void:
	_dialogue.rect_size = Vector2.ZERO
	_right_choice.visible = right_choice
	_left_choice.visible = left_choice
	_dialogue.autowrap = false
	_dialogue.text = speech
	
	_dialogue.visible_characters = 0
#	_set_box_size(face_right)
	if _dialogue.rect_size.x > rect_max_size.x:
		rect_size.x = rect_max_size.x
		_dialogue.autowrap = true
			
	show()


func try_continue() -> bool:
	if _dialogue.visible_characters < _dialogue.text.length():
		_dialogue.visible = -1
		return false
	else:
		return true


func close() -> void:
	_dialogue.text = ""
	_dialogue.visible_characters = 0
	hide()

# switch to a dynamically scaled container/ use the draw function to connect to the 
# character maybe have a fixed height for displaying it
func _set_box_size(facing_right : bool) -> void:
	var dir_str := "Left"
	if facing_right:
		dir_str = "Right"
	$AnimationPlayer.play("LargeTop" + dir_str)
