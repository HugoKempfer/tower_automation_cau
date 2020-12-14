extends Node

class TileData:
	var is_terrain_constructible: bool
	var construction_state := ""
	func _init(_is_terrain_constructible: bool):
		self.is_terrain_constructible = _is_terrain_constructible

export var constructible_tile_names = ["Tile"] # Add all non-obstacle tile names
var constructible_tile_ids = []
var being_positioned_building: Building = null
onready var tileset_node := $GridMap as GridMap
var tiles: = {}
var to_spawn = []

enum BuildingTypes {
	TURRET_DOUBLE = 0,
	TURRET_SINGLE,
	WEAPON_BLASTER,
	RESSOURCE_GETTER
}

const building_types = {
	BuildingTypes.TURRET_DOUBLE: preload("res://components/constructible/turret_double.tscn"),
	BuildingTypes.TURRET_SINGLE: preload("res://components/constructible/turret_single.tscn"),
	BuildingTypes.WEAPON_BLASTER: preload("res://components/constructible/weapon_blaster.tscn"),
	BuildingTypes.RESSOURCE_GETTER: preload("res://components/constructible/ressource_getter.tscn")
}

func _ready() -> void:
	for tile in constructible_tile_names:
		constructible_tile_ids.append(self.tileset_node.mesh_library.find_item_by_name(tile))

	var cells = tileset_node.get_used_cells()
	for cell in cells:
		var current_cell_tile_id: int = self.tileset_node.get_cell_item(cell.x, cell.y, cell.z)
		tiles[cell as Vector3] = TileData.new(self.constructible_tile_ids.has(current_cell_tile_id))

func enable_building_mode() -> void:
	var buildable = preload("res://components/constructible/buildable_tile.tscn")
	for tile_pos in tiles.keys():
		var tile: TileData = tiles[tile_pos]
		if tile.is_terrain_constructible:
			var current = buildable.instance()
			current.pos_init(tile_pos, tile_pos)
			#current.pos_init($GridMap.map_to_world(tile_pos.x, tile_pos.y, tile_pos.z), tile_pos)
			$GridMap.add_child(current)
			current.add_to_group("available_tiles")
			current.connect("buildable_tile_hovered", self, "handle_tile_hover")

func disable_building_mode() -> void:
	for tile in get_tree().get_nodes_in_group("available_tiles"):
		tile.queue_free()

func can_be_positioned_on_tile(size: int, origin: Vector3) -> bool:
	origin.y = 0
	if not self.tiles.has(origin):
		return false
	for x in range(0, size):
		for z in range(0, size):
			if not self.tiles[Vector3(origin.x + x, origin.y, origin.z + z)].is_terrain_constructible:
				return false
	return true

func handle_tile_hover(pos: Vector3) -> void:
	if self.being_positioned_building and can_be_positioned_on_tile(self.being_positioned_building.size, pos):
		self.being_positioned_building.transform.origin = pos

func enable_building_positioning(building: Building):
	self.being_positioned_building = building
	self.enable_building_mode()

# To delete
func spawn_core():
	var core := preload("res://components/constructible/Core.tscn")
	var new_core = core.instance()
	$Constructions.add_child(new_core)
	self.enable_building_positioning(new_core)

func try_positioning_building():
	if can_be_positioned_on_tile(self.being_positioned_building.size, self.being_positioned_building.transform.origin):
		self.being_positioned_building.add_to_group("buildings")
		self.being_positioned_building.on_positioned()
		self.disable_building_mode()
		self.being_positioned_building.is_positioned = true
		self.being_positioned_building = null
		# TODO => update used tile datas

func _unhandled_input(event):
	if event.is_action("click_on_environment") and self.being_positioned_building:
		self.try_positioning_building()
	if event.is_action("focus_home") && self.being_positioned_building == null:
		self.spawn_core()

func spawn_buildings(building_type: int) -> void:
	var new_building: Building = building_types[building_type].instance()
	$Constructions.add_child(new_building)
	self.enable_building_positioning(new_building)

func _on_PlayerInterface_selected_building(building_type):
	if being_positioned_building == null:
		spawn_buildings(building_type)
