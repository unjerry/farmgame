extends Node
signal inventory_changed
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
func add_crop(amount: int = 1) -> void:
    crop_count += amount
    print("crops: ", crop_count)
    inventory_changed.emit()
