extends Node
var economy := {}
var items := {}
var crops := {}
func _ready() -> void:
	load_economy_config()
	load_items_config()
	load_crops_config()
func load_economy_config() -> void:
	var file_text := FileAccess.get_file_as_string("res://data/economy.json")
	var parsed_data = JSON.parse_string(file_text)
	if parsed_data == null:
		push_error("Failed to load economy.json")
		return
	economy = parsed_data
func load_items_config() -> void:
	var file_text := FileAccess.get_file_as_string("res://data/items.json")
	var parsed_data = JSON.parse_string(file_text)
	if parsed_data == null:
		push_error("Failed to load items.json")
		return
	items = parsed_data
func load_crops_config() -> void:
	var file_text := FileAccess.get_file_as_string("res://data/crops.json")
	var parsed_data = JSON.parse_string(file_text)
	if parsed_data == null:
		push_error("Failed to load crops.json")
		return
	crops = parsed_data
func get_starting_money() -> int:
	return economy.get("starting_money", 100)
func get_starting_seeds() -> int:
	return economy.get("starting_seeds", 5)
func get_seed_price() -> int:
	return economy.get("seed_price", 10)
func get_crop_sell_price() -> int:
	return economy.get("crop_sell_price", 25)
func get_item_data(item_id: String) -> Dictionary:
	return items.get(item_id, {})
func get_crop_data(crop_id: String) -> Dictionary:
	return crops.get(crop_id, {})
