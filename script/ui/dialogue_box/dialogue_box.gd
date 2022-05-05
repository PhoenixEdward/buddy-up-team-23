class_name DialogueBox
extends Control

signal expired()

const TIME_PER_CHAR := 0.05
const MAX_TAIL_RANGE := 256.0
const MAX_SLEEP_TIME := 4.0

export var rect_max_size : Vector2

var _time_since_char := 0.0
var _speaking_offset : Vector2
var _connet_rect := Rect2(Vector2.ZERO, Vector2.RIGHT * 64)
var speaker : Character
var sleeping := false

onready var _dialogue : Label = $Background/MarginContainer/Dialogue
onready var _background : PanelContainer = $Background
onready var _right_choice : TextureRect = $Background/RightChoice
onready var _left_choice : TextureRect = $Background/LeftChoice

func _ready() -> void:
	hide()


func _process(delta: float) -> void:

	rect_position = Vector2(speaker.body.get_global_transform_with_canvas().origin.x - _background.rect_size.x / 2.0, 128) 
	
	if rect_position.x < 0:
		rect_position.x = 0
	elif rect_position.x + _background.rect_size.x > get_viewport_rect().size.x:
		rect_position.x = get_viewport_rect().size.x - _background.rect_size.x

	_speaking_offset = speaker.body.get_global_transform_with_canvas().origin - rect_position
	
	var connect_rect_pos := Vector2(speaker.body.get_global_transform_with_canvas().origin.x - rect_position.x, _background.rect_size.y)
	
	if connect_rect_pos.x < _background.rect_position.x:
		connect_rect_pos.x = _background.rect_positon.x
	elif connect_rect_pos.x > _background.rect_position.x + _background.rect_size.x - 64:
		connect_rect_pos.x = _background.rect_position.x + _background.rect_size.x - 64
	
	_connet_rect.position = connect_rect_pos
	update()
	
	if visible and not sleeping:
		if _dialogue.visible_characters < _dialogue.text.length():
			_time_since_char += delta
			if _time_since_char >= TIME_PER_CHAR:
				_time_since_char = 0
				_dialogue.visible_characters += 1
		else:
			sleeping = true
			yield(get_tree().create_timer(MAX_SLEEP_TIME), "timeout")
			emit_signal("expired")
			sleeping = false
			return
		

func _draw() -> void:
	draw_colored_polygon(PoolVector2Array([_connet_rect.position, _connet_rect.end, lerp(_connet_rect.position + _connet_rect.size, _speaking_offset, 0.5)]), Color8(255,255,222))

func speak(speech : String, face_right : bool,
left_choice := false, right_choice := false) -> void:
	_dialogue.rect_size = Vector2.ZERO
	_right_choice.visible = right_choice
	_left_choice.visible = left_choice
	_dialogue.autowrap = false
	_dialogue.text = speech
	_dialogue.visible_characters = 0
	_time_since_char = INF
#	_set_box_size(face_right)
	if _dialogue.get_font("font").get_string_size(_dialogue.text).x > rect_max_size.x:
		rect_size.x = rect_max_size.x
		_dialogue.autowrap = true
			
	show()


func try_continue() -> bool:
	if _dialogue.visible_characters < _dialogue.text.length():
		_dialogue.visible = -1
		return false
	else:
		return true
	sleeping = false


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
