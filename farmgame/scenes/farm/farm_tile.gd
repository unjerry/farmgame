extends Area2D
@export var crop_scene: PackedScene
var is_tilled := false
var has_crop := false
var is_watered := false
var planted_crop: Node2D = null
func till() -> void:
	is_tilled = true
	$Sprite2D.modulate = Color(0.55, 0.32, 0.18)
func plant() -> bool:
	if not is_tilled:
		return false
	if has_crop:
		return false
	has_crop = true
	planted_crop = crop_scene.instantiate()
	add_child(planted_crop)
	planted_crop.position = Vector2.ZERO
	return true
func water() -> void:
	if not has_crop:
		return
	is_watered = true
	$Sprite2D.modulate = Color(0.1, 0.5, 0.35)
func grow_crop() -> void:
	if planted_crop == null:
		return
	if not is_watered:
		return
	if planted_crop.has_method("grow"):
		planted_crop.grow()
	is_watered = false
	$Sprite2D.modulate = Color(0.55, 0.32, 0.18)
func harvest() -> bool:
	if planted_crop == null:
		return false
	if not planted_crop.has_method("is_mature"):
		return false
	if not planted_crop.is_mature():
		return false
	planted_crop.queue_free()
	planted_crop = null
	has_crop = false
	is_watered = false
	$Sprite2D.modulate = Color(0.55, 0.32, 0.18)
	print("harvested crop")
	return true
