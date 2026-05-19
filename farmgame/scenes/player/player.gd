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
func get_closest_tile_with_method(method_name: String) -> Area2D:
	var areas := interaction_area.get_overlapping_areas()
	var closest_tile: Area2D = null
	var closest_distance := 999999.0
	for area in areas:
		if area.has_method(method_name):
			var distance := interaction_area.global_position.distance_to(area.global_position)
			if distance < closest_distance:
				closest_distance = distance
				closest_tile = area
	return closest_tile
func use_tool() -> void:
	if current_tool == "hoe":
		use_hoe()
	elif current_tool == "seed":
		use_seed()
	elif current_tool == "watering_can":
		use_watering_can()
	elif current_tool == "hand":
		use_hand()
func use_hand() -> void:
	var tile := get_closest_tile_with_method("harvest")
	if tile == null:
		return
	var harvested: bool = tile.harvest()
	if harvested:
		InventoryManager.crop_count += 1
		print("crop: ", InventoryManager.crop_count)
func use_watering_can() -> void:
	var tile := get_closest_tile_with_method("water")
	if tile != null:
		tile.water()
func use_hoe() -> void:
	var tile := get_closest_tile_with_method("till")
	if tile != null:
		tile.till()
func use_seed():
	if InventoryManager.seed_count <= 0:
		print("no seeds")
		return
	var tile := get_closest_tile_with_method("plant")
	if tile == null:
		return
	var planted: bool = tile.plant()
	if planted:
		InventoryManager.seed_count -= 1
		print("seed: ", InventoryManager.seed_count)
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		if event.keycode == KEY_1:
			current_tool = "hoe"
			print("current tool: hoe")
		elif event.keycode == KEY_2:
			current_tool = "seed"
			print("current tool: seed")
		elif event.keycode == KEY_3:
			current_tool = "watering_can"
			print("current tool: watering_can")
		elif event.keycode == KEY_4:
			current_tool = "hand"
			print("current tool: hand")
