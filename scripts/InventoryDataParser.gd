extends Node

var url = "res://Database//inventory.json"

func _ready():
	pass
	
func get_item_by_name(name):
	var data = {}
	
	data = DataParser.load_data(url)
	for i in range (1, (data.size() + 1)):
		if data[String(i)]["name"] == name:
			return data[String(i)]
	print("Item not found")
	return
	
func edit_item_quantity(name, quantity, isAdding):
	var resources = {"1": InventoryDataParser.get_item_by_name("copper"),
					"2": InventoryDataParser.get_item_by_name("coal"),
					"3": InventoryDataParser.get_item_by_name("iron"),
					"4": InventoryDataParser.get_item_by_name("lead"),
					"5": InventoryDataParser.get_item_by_name("oil"),
					"6": InventoryDataParser.get_item_by_name("uranium")}
					
	for i in range (1, (resources.size() + 1)):
		if resources[String(i)]["name"] == name:
			if isAdding:
				resources[String(i)]["quantity"] = resources[String(i)]["quantity"] + quantity
			else:
				resources[String(i)]["quantity"] = resources[String(i)]["quantity"] - quantity
			break
	DataParser.write_data(url, resources)
