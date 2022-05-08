class_name AssetImport
extends Control

var select_player_body := false
var select_player_wheels := false
var companion_body_select := false

var import_scaled := true
onready var file_dialogue : FileDialog = $FileDialog
onready var player_body_sprite : Sprite = get_tree().get_nodes_in_group("player")[0].get_node("Body/Sprite")
onready var player_wheel_sprite : Sprite = get_tree().get_nodes_in_group("player")[0].get_node("Wheels/Sprite")
onready var companion_sprite : Sprite = get_tree().get_nodes_in_group("companion")[0].get_node("Body/Sprite")
onready var player_body_spin_box : SpinBox = $PanelContainer/MarginContainer/GraphicsImport/PlayerBodyPixelWidth/PixelWidthEdit
onready var player_wheel_spin_box : SpinBox = $PanelContainer/MarginContainer/GraphicsImport/PlayerWheelPixelWidth/PixelWidthEdit
onready var companion_spin_box : SpinBox = $PanelContainer/MarginContainer/GraphicsImport/CompanionPixelWidth/PixelWidthEdit

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
		_push_texture_path_to_sprite(path, player_body_sprite, player_body_spin_box.value)
	elif select_player_wheels:
		_push_texture_path_to_sprite(path, player_wheel_sprite, player_wheel_spin_box.value)
	elif companion_body_select:
		_push_texture_path_to_sprite(path, companion_sprite, companion_spin_box.value)

func _push_texture_path_to_sprite(path: String, sprite : Sprite, max_size : float) -> void:
	var image = Image.new()
	image.load(path)
	var t = ImageTexture.new()
	t.create_from_image(image)
	sprite.scale = Vector2.ONE
	sprite.texture = t
	scale_sprite(sprite, max_size)
	

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


func _on_PlayerBodyPixelWidthEdit_value_changed(value: float) -> void:
	scale_sprite(player_body_sprite, value)


func scale_sprite(sprite : Sprite, max_size : float) -> void:
	sprite.scale = max_size/sprite.texture.get_size().x * Vector2.ONE

func _on_PlayerWheelPixelWidthEdit_value_changed(value: float) -> void:
	scale_sprite(player_wheel_sprite, value)
	


func _on_CompanionPixelWidthEdit_value_changed(value: float) -> void:
	scale_sprite(companion_sprite, value)
