extends Area2D
var is_tilled := false
func till() -> void:
	is_tilled = true
	$Sprite2D.modulate = Color(0.55, 0.32, 0.18)
