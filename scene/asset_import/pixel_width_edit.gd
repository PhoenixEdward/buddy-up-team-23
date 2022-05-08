class_name PixelWidthEdit
extends HBoxContainer

func _ready() -> void:
	$PixelWidthEdit.get_line_edit().add_font_override("font", $Label.get_font("font"))
