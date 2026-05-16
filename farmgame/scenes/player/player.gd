extends CharacterBody2D
var speed := 120.0
var current_tool := "hoe"
@onready var interaction_area: Area2D = $InteractionArea
func _physics_process(_delta: float) -> void:
	var direction := get_input_direction()
	move_player(direction)
	if Input.is_action_just_pressed("ui_accept"):
		use_tool()
func get_input_direction() -> Vector2:
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	return direction
func move_player(direction: Vector2) -> void:
	velocity = direction * speed
	move_and_slide()
func use_tool() -> void:
	if current_tool == "hoe":
		use_hoe()
func use_hoe() -> void:
	var areas := interaction_area.get_overlapping_areas()
	var closest_tile: Area2D = null
	var closest_distance := 999999.0
	for area in areas:
		if area.has_method("till"):
			var distance := interaction_area.global_position.distance_to(area.global_position)
			if distance < closest_distance:
				closest_distance = distance
				closest_tile = area
	if closest_tile != null:
		closest_tile.till()
