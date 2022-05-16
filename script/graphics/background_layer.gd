class_name BackgroundLayer
extends Sprite

export var tile_count : int
export(Vector2) var subtile_counts : Vector2 = Vector2.ONE

func _ready() -> void:
	for i in range(tile_count):
		var sprite := Sprite.new()
		sprite.texture = texture
		sprite.centered = false
		sprite.position = (texture.get_size() * subtile_counts) * ((i + 1) * Vector2.RIGHT)
		add_child(sprite)
	if get_node("VisibilityNotifier2D") != null:
		$VisibilityNotifier2D.connect("screen_entered", self, "_on_screen_entered")
		$VisibilityNotifier2D.connect("screen_exited", self, "_on_screen_exited")
	hide()

func _on_screen_entered() -> void:
	show()
func _on_screen_exited() -> void:
	hide()
