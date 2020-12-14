extends Node

onready var file = File.new()

func load_data(url):
	var data = {}

	if url == null:
		return
	if !file.file_exists(url):
		return
	file.open(url, File.READ)
	data = parse_json(file.get_as_text())
	file.close()
	return data

func write_data(url, data):
	if url == null:
		return
	file.open(url, File.WRITE)
	file.store_line(JSON.print(data))
	file.close()
	return
