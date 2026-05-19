extends Node2D
var growth_stage := 0
var max_growth_stage := 3
@onready var sprite: Sprite2D = $Sprite2D
func _ready() -> void:
	update_visual()
func grow() -> void:
	if growth_stage >= max_growth_stage:
		return
	growth_stage += 1
	update_visual()
func update_visual() -> void:
	var scale_value := 0.18 + growth_stage * 0.08
	sprite.scale = Vector2(scale_value, scale_value)
	if growth_stage >= max_growth_stage:
		sprite.modulate = Color(1.0, 0.9, 0.2)
	else:
		sprite.modulate = Color(0.2, 0.8, 0.2)
func is_mature() -> bool:
	return growth_stage >= max_growth_stage
