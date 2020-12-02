extends CanvasLayer

onready var itemList = get_node("Panel/ItemList")

func _ready():
	init_inventory()
	edit_player_resource("copper", 100, false)
	pass

func init_inventory():
	var resources = [InventoryDataParser.get_item_by_name("copper"),
					InventoryDataParser.get_item_by_name("coal"),
					InventoryDataParser.get_item_by_name("iron"),
					InventoryDataParser.get_item_by_name("lead"),
					InventoryDataParser.get_item_by_name("oil"),
					InventoryDataParser.get_item_by_name("uranium")]
	
	itemList.max_columns = 3
	itemList.fixed_icon_size = Vector2(48, 48)
	itemList.icon_mode = ItemList.ICON_MODE_TOP
	itemList.same_column_width = true	
	for i in range (0, resources.size()):
		itemList.add_item(resources[i]["name"] + " : " + String(resources[i]["quantity"]), ResourceLoader.load(resources[i]["icon"]), true)
	
func update_inventory():
	var resources = [InventoryDataParser.get_item_by_name("copper"),
					InventoryDataParser.get_item_by_name("coal"),
					InventoryDataParser.get_item_by_name("iron"),
					InventoryDataParser.get_item_by_name("lead"),
					InventoryDataParser.get_item_by_name("oil"),
					InventoryDataParser.get_item_by_name("uranium")]
	
	itemList.clear()
	for i in range (0, resources.size()):
		itemList.add_item(resources[i]["name"] + " : " + String(resources[i]["quantity"]), ResourceLoader.load(resources[i]["icon"]), true)
	
func edit_player_resource(name, quantity, isAdding):
	InventoryDataParser.edit_item_quantity(name, quantity, isAdding)
	update_inventory()
