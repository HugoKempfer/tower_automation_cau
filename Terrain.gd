extends Node


class TileData:
	var is_terrain_constructible: bool
	var construction_state := ""

	func _init(is_terrain_constructible: bool):
		self.is_terrain_constructible = is_terrain_constructible

export var constructible_tile_names = ["Tile"]
var constructible_tile_ids = []

onready var tileset_node := $GridMap as GridMap
var tiles: = {}

func _ready() -> void:
	for tile in constructible_tile_names:
		constructible_tile_ids.append(self.tileset_node.mesh_library.find_item_by_name(tile))

	var cells = tileset_node.get_used_cells()
	for cell in cells:
		var current_cell_tile_id: int = self.tileset_node.get_cell_item(cell.x, cell.y, cell.z)
		tiles[cell as Vector3] = TileData.new(self.constructible_tile_ids.has(current_cell_tile_id))
	for tile in self.tiles.values():
		print(var2str(tile))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
