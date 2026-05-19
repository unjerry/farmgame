extends Node
signal inventory_changed
var money := 0
var items := {}
func _ready() -> void:
	money = ConfigManager.get_starting_money()
	items["turnip_seed"] = ConfigManager.get_starting_seeds()
	items["turnip"] = 0
	inventory_changed.emit()
func get_item_count(item_id: String) -> int:
	return int(items.get(item_id, 0))
func get_all_items() -> Dictionary:
	return items.duplicate()
func has_item(item_id: String, amount: int = 1) -> bool:
	return get_item_count(item_id) >= amount
func add_item(item_id: String, amount: int = 1) -> void:
	var current_count := get_item_count(item_id)
	items[item_id] = current_count + amount
	print(item_id, ": ", get_item_count(item_id))
	inventory_changed.emit()
func remove_item(item_id: String, amount: int = 1) -> bool:
	if not has_item(item_id, amount):
		print("not enough item: ", item_id)
		return false
	items[item_id] = get_item_count(item_id) - amount
	print(item_id, ": ", get_item_count(item_id))
	inventory_changed.emit()
	return true
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
