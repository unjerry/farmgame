extends Area2D
var is_tilled := false
func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		till()
func till() -> void:
	is_tilled = true
	$Sprite2D.modulate = Color(0.55, 0.32, 0.18)
