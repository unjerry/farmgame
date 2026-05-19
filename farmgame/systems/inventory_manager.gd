extends Node
signal inventory_changed
var money := 0
var seed_count := 0
var crop_count := 0
var items := {}
func _ready() -> void:
	money = ConfigManager.get_starting_money()
	items["turnip_seed"] = ConfigManager.get_starting_seeds()
	items["turnip"] = 0
	sync_legacy_counts()
	inventory_changed.emit()
func sync_legacy_counts() -> void:
	seed_count = get_item_count("turnip_seed")
	crop_count = get_item_count("turnip")
func get_item_count(item_id: String) -> int:
	return int(items.get(item_id, 0))
func has_item(item_id: String, amount: int = 1) -> bool:
	return get_item_count(item_id) >= amount
func add_item(item_id: String, amount: int = 1) -> void:
	var current_count := get_item_count(item_id)
	items[item_id] = current_count + amount
	sync_legacy_counts()
	print(item_id, ": ", get_item_count(item_id))
	inventory_changed.emit()
func remove_item(item_id: String, amount: int = 1) -> bool:
	if not has_item(item_id, amount):
		print("not enough item: ", item_id)
		return false
	items[item_id] = get_item_count(item_id) - amount
	sync_legacy_counts()
	print(item_id, ": ", get_item_count(item_id))
	inventory_changed.emit()
	return true
func consume_seed() -> bool:
	return remove_item("turnip_seed", 1)
func add_seed(amount: int = 1) -> void:
	add_item("turnip_seed", amount)
func add_crop(amount: int = 1) -> void:
	add_item("turnip", amount)
func remove_crop(amount: int = 1) -> bool:
	return remove_item("turnip", amount)
func spend_money(amount: int) -> bool:
	if money < amount:
		print("not enough money")
		return false
	money -= amount
	print("money: ", money)
	inventory_changed.emit()
	return true
func add_money(amount: int) -> void:
	money += amount
	print("money: ", money)
	inventory_changed.emit()
