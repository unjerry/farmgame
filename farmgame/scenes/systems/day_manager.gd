extends Node
signal day_changed
var current_day := 1
func next_day() -> void:
	current_day += 1
	print("day: ", current_day)
	day_changed.emit()
