extends TextureButton

var base_amount = 40

func _on_button_down() -> void:
	position += Vector2.DOWN * base_amount


func _on_button_up() -> void:
	position += Vector2.UP * base_amount
