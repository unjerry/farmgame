extends Node2D
@export var farm_tile_scene: PackedScene
var grid_width := 3
var grid_height := 4
var tile_stride := 64
var farm_start_position := Vector2(100, 200)
func _ready() -> void:
	create_farm_tile()
func create_farm_tile() -> void:
	for y in grid_height:
		for x in grid_width:
			var farm_tile := farm_tile_scene.instantiate()
			farm_tile.name = "FarmTile_%s_%s" % [x, y]
			$FarmTiles.add_child(farm_tile)
			farm_tile.position = farm_start_position + Vector2(x * tile_stride, y * tile_stride)
