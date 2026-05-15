extends CharacterBody2D
var speed := 120.0
func _physics_process(_delta: float) -> void:
	var direction := get_input_direction()
	move_player(direction)
func get_input_direction() -> Vector2:
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	return direction
func move_player(direction: Vector2) -> void:
	velocity = direction * speed
	move_and_slide()
