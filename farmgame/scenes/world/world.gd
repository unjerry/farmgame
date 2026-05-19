extends Node2D
@export var farm_tile_scene: PackedScene
var grid_width := 3
var grid_height := 4
var tile_stride := 64
var farm_start_position := Vector2(100, 200)
func _ready() -> void:
	DayManager.day_changed.connect(_on_day_changed)
	create_farm_tile()
func create_farm_tile() -> void:
	for y in grid_height:
		for x in grid_width:
			var farm_tile := farm_tile_scene.instantiate()
			farm_tile.name = "FarmTile_%s_%s" % [x, y]
			$FarmTiles.add_child(farm_tile)
			farm_tile.position = farm_start_position + Vector2(x * tile_stride, y * tile_stride)
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		if event.keycode == KEY_N:
			DayManager.next_day()
		elif event.keycode == KEY_B:
			ShopManager.buy_seed()
		elif event.keycode == KEY_S:
			ShopManager.sell_crop()
func _on_day_changed() -> void:
	grow_all_crops()
func grow_all_crops() -> void:
	for farm_tile in $FarmTiles.get_children():
		if farm_tile.has_method("grow_crop"):
			farm_tile.grow_crop()
