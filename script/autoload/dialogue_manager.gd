extends Node

const TIME_PER_CHAR := 0.1

var player_dialogue_box : DialogueBox

var _time_since_char
var _active : bool = false
var _line_idx := 0
var _dialogue_msg : DialoguePath
var _callback : FuncRef
var _active_speaker_box : DialogueBox
var npc_dialogue_box : DialogueBox
var _current_choice : int = 0


func play_dialogue(dialogue_message : DialoguePath, callback : FuncRef = null, interactable_db : DialogueBox = null) -> void:
	if _active:
		_exit()
	
	GameState.state = GameState.State.IN_DIALOGUE

	if interactable_db:
		npc_dialogue_box = interactable_db
	
	if callback:
		_callback = callback
	
	_dialogue_msg = dialogue_message
	
	if not _active:
		_active = true
		
	_push_dialogue_to_box(_line_idx)


func _exit() -> void:
	GameState.state = GameState.State.ROAMING
	if _active_speaker_box.is_connected("expired", self, "_on_dialogue_expired"):
		_active_speaker_box.disconnect("expired", self, "_on_dialogue_expired")
	_active_speaker_box.close()
	_dialogue_msg = null
	_line_idx = 0
	_active_speaker_box = null
	_active = false
	_current_choice = 0
	if _callback != null:
		_callback.call_func()
	_callback = null


func _next_line() -> void:
	_line_idx += 1
	
	if _line_idx > _dialogue_msg.speech.size() - 1:
		_next_path(_current_choice)
		return
			
	_push_dialogue_to_box(_line_idx)


func _next_path(index : int) -> void:
	if _dialogue_msg.next_paths.size() == 0:
		_exit()
		return
	elif _dialogue_msg.next_paths[index] == null: 
		_exit()
		return
		
	_line_idx = 0
	_current_choice = 0
	_dialogue_msg = _dialogue_msg.next_paths[index]
	_push_dialogue_to_box(_line_idx)


func _push_dialogue_to_box(index : int) -> void:
	if _active_speaker_box != null:
		if _active_speaker_box.is_connected("expired", self, "_on_dialogue_expired"):
			_active_speaker_box.disconnect("expired", self, "_on_dialogue_expired")
		_active_speaker_box.close()
		
	var face_right = false
	
	if _dialogue_msg.speakers[index] == DialoguePath.Speaker.NPC:
		_active_speaker_box = npc_dialogue_box
		if npc_dialogue_box.rect_global_position.x > player_dialogue_box.rect_global_position.x:
			face_right = true
	else:
		_active_speaker_box = player_dialogue_box
		if npc_dialogue_box != null:
			if npc_dialogue_box.rect_global_position.x < player_dialogue_box.rect_global_position.x:
				face_right = true
			
	var left_choice = true if _current_choice > 0 else false
	var right_choice = true if _current_choice < _dialogue_msg.next_paths.size() - 1 else false
			
	_active_speaker_box.connect("expired", self, "_on_dialogue_expired")
	_active_speaker_box.speak(_dialogue_msg.speech[index], face_right, left_choice, right_choice)


func _on_dialogue_expired() -> void:
	if not _dialogue_msg.is_choice:
		if _active_speaker_box.try_continue():
			_next_line()

func _input(event: InputEvent) -> void:
	if _active:
		if event.is_action_pressed("ui_accept"):
			if not _dialogue_msg.is_choice:
				if _active_speaker_box.try_continue():
					_next_line()
			else:
				_next_path(_current_choice)
			get_tree().set_input_as_handled()
#		if event.is_action_pressed("move_left"):
#			if _current_choice > 0:
#				_current_choice -= 1
#				_push_dialogue_to_box(_current_choice)
#			get_tree().set_input_as_handled()
#		if event.is_action_pressed("move_right"):
#			if _current_choice < _dialogue_msg.next_paths.size() - 1:
#				_current_choice += 1
#				_push_dialogue_to_box(_current_choice)
#			get_tree().set_input_as_handled()
