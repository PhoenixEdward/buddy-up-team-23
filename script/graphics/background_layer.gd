class_name BackgroundLayer
extends Sprite

export var tile_count : int

func _ready() -> void:
	for i in range(tile_count):
		var sprite := Sprite.new()
		sprite.texture = texture
		sprite.position = texture.get_size() * ((i + 1) * Vector2.RIGHT)
		add_child(sprite)
