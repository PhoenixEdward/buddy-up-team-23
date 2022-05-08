class_name AssetImport
extends Control

var select_player_body := false
var select_player_wheels := false
var companion_body_select := false

var import_scaled := true
onready var file_dialogue : FileDialog = $FileDialog

func _ready() -> void:
	file_dialogue.set_as_toplevel(true)
	if visible:
		hide()


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		var key := event as InputEventKey
		if key.scancode == KEY_CONTROL and key.pressed:
			if not visible:
				show()
			else:
				hide()
			


func _on__player_body_select_button_pressed() -> void:
	select_player_body = true
	file_dialogue.popup_centered()


func _on_file_selected(path: String) -> void:
	if select_player_body:
		_push_texture_path_to_sprite(path, get_tree().get_nodes_in_group("player")[0].get_node("Body/Sprite"), 96)
	elif select_player_wheels:
		_push_texture_path_to_sprite(path, get_tree().get_nodes_in_group("player")[0].get_node("Wheels/Sprite"), 64)
	elif companion_body_select:
		_push_texture_path_to_sprite(path, get_tree().get_nodes_in_group("companion")[0].get_node("Body/Sprite"), 48)

func _push_texture_path_to_sprite(path: String, sprite : Sprite, max_size : float) -> void:
	var image = Image.new()
	image.load(path)
	var t = ImageTexture.new()
	t.create_from_image(image)
	sprite.scale = Vector2.ONE
	sprite.texture = t
	if import_scaled:
		if t.get_size().x > max_size:
			sprite.scale *= max_size/t.get_size().x
	

func _on_FileDialog_popup_hide() -> void:
	select_player_body = false
	select_player_wheels = false
	companion_body_select = false


func _on_PlayerWheelsSelectButton_pressed() -> void:
	select_player_wheels = true
	file_dialogue.popup_centered()

func _on_CompanionBodySelectButton_pressed() -> void:
	companion_body_select = true
	file_dialogue.popup_centered()
