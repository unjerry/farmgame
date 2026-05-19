extends Node
signal inventory_changed
var money := 100
var seed_count := 5
var crop_count := 0
func consume_seed() -> bool:
	if seed_count <= 0:
		print("no seeds")
		return false
	seed_count -= 1
	print("seeds: ", seed_count)
	inventory_changed.emit()
	return true
func add_seed(amount: int = 1) -> void:
	seed_count += amount
	print("seeds: ", seed_count)
	inventory_changed.emit()
func add_crop(amount: int = 1) -> void:
	crop_count += amount
	print("crops: ", crop_count)
	inventory_changed.emit()
func remove_crop(amount: int = 1) -> bool:
	if crop_count < amount:
		print("not enough crops")
		return false
	crop_count -= amount
	print("crops: ", crop_count)
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
