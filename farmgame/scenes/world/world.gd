extends Node2D
@export var farm_tile_scene: PackedScene
func _ready() -> void:
	create_one_farm_tile()
func create_one_farm_tile() -> void:
	var farm_tile := farm_tile_scene.instantiate()
	$FarmTiles.add_child(farm_tile)
	farm_tile.position = Vector2(300, 300)
