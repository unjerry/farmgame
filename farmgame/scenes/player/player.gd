extends CharacterBody2D
var speed := 120.0
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
	var item_data := ToolManager.get_selected_item_data()
	var item_type: String = item_data.get("type", "")
	if item_type == "tool":
		use_tool_item(item_data)
	elif item_type == "seed":
		use_seed()
func use_tool_item(item_data: Dictionary) -> void:
	var tool_action: String = item_data.get("tool_action", "")
	if tool_action == "till":
		use_hoe()
	elif tool_action == "water":
		use_watering_can()
	elif tool_action == "harvest":
		use_hand()
func use_hand() -> void:
	var tile := get_closest_tile_with_method("harvest")
	if tile == null:
		return
	var harvested_result: Dictionary = tile.harvest()
	if harvested_result.is_empty():
		return
	var item_id: String = harvested_result.get("item_id", "")
	var amount: int = harvested_result.get("amount", 1)
	if item_id == "":
		return
	InventoryManager.add_item(item_id, amount)
func use_watering_can() -> void:
	var tile := get_closest_tile_with_method("water")
	if tile != null:
		tile.water()
func use_hoe() -> void:
	var tile := get_closest_tile_with_method("till")
	if tile != null:
		tile.till()
func use_seed() -> void:
	var seed_item_id := ToolManager.selected_item_id
	var seed_data: Dictionary = ConfigManager.get_item_data(seed_item_id)
	var crop_id: String = seed_data.get("crop_id", "")
	if crop_id == "":
		print("seed has no crop_id: ", seed_item_id)
		return
	var tile := get_closest_tile_with_method("plant")
	if tile == null:
		return
	if not tile.has_method("can_plant"):
		return
	if not tile.can_plant():
		return
	if not InventoryManager.remove_item(seed_item_id, 1):
		return
	tile.plant(crop_id)
