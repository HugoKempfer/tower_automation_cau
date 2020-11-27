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
	self.enable_building_mode()


func enable_building_mode() -> void:
	var buildable = preload("res://components/constructible/buildable_tile.tscn")
	for tile_pos in tiles.keys():
		var tile: TileData = tiles[tile_pos]
		if tile.is_terrain_constructible:
			var current = buildable.instance()
			current.pos_init($GridMap.map_to_world(tile_pos.x, tile_pos.y, tile_pos.z), tile_pos)
			$GridMap.add_child(current)
			current.add_to_group("available_tiles")
			current.connect("buildable_tile_hovered", self, "handle_tile_hover")

func disable_building_mode() -> void:
	for tile in get_tree().get_nodes_in_group("buildable_tile_hovered"):
		tile.queue_free()

func handle_tile_hover(pos: Vector3) -> void:
	print("Tile hovered, pos => ", pos)
	$Constructions/Core.transform.origin = pos
