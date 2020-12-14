extends CanvasLayer

onready var resource_list: ItemList = $MainContainer/VerticalContainer/Menu/AlignMenu/ResourceList
onready var building_list: ItemList = $MainContainer/VerticalContainer/Menu/AlignMenu/BuildingList
export var buildings_names = ["turret_double", "turret_single", "weapon_blaster", "ressource_getter"]

signal selected_building(building_type)

func _ready():
	var timer = Timer.new()

	init_inventory()
	initialize_buildings()
	timer.set_wait_time(1.0)
	timer.set_one_shot(false)
	timer.connect("timeout", self, "update_inventory")
	add_child(timer)
	timer.start()
	pass

func init_inventory() -> void:
	var resources = [InventoryDataParser.get_item_by_name("copper"),
					InventoryDataParser.get_item_by_name("coal"),
					InventoryDataParser.get_item_by_name("iron"),
					InventoryDataParser.get_item_by_name("lead"),
					InventoryDataParser.get_item_by_name("oil"),
					InventoryDataParser.get_item_by_name("uranium")]

	resource_list.max_columns = 3
	resource_list.fixed_icon_size = Vector2(48, 48)
	resource_list.icon_mode = resource_list.ICON_MODE_TOP
	resource_list.same_column_width = true
	for i in range (0, resources.size()):
		resource_list.add_item(resources[i]["name"] + " : " + String(resources[i]["quantity"]), ResourceLoader.load(resources[i]["icon"]), true)

func update_inventory() -> void:
	var resources = [InventoryDataParser.get_item_by_name("copper"),
					InventoryDataParser.get_item_by_name("coal"),
					InventoryDataParser.get_item_by_name("iron"),
					InventoryDataParser.get_item_by_name("lead"),
					InventoryDataParser.get_item_by_name("oil"),
					InventoryDataParser.get_item_by_name("uranium")]
	resource_list.clear()
	for i in range (0, resources.size()):
		resource_list.add_item(resources[i]["name"] + " : " + String(resources[i]["quantity"]), ResourceLoader.load(resources[i]["icon"]), true)

func edit_player_resource(name, quantity, isAdding):
	InventoryDataParser.edit_item_quantity(name, quantity, isAdding)

func initialize_buildings() -> void:
	building_list.max_columns = 3
	building_list.fixed_icon_size = Vector2(48, 48)
	building_list.icon_mode = resource_list.ICON_MODE_TOP
	building_list.same_column_width = true
	for building_name in buildings_names:
		var resource = ResourceLoader.load("res://assets/Side/%s.png" % building_name)
		building_list.add_item(building_name, resource, true)

func _on_BuildingList_item_selected(index):
	emit_signal("selected_building", index)
