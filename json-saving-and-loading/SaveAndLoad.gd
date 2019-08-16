extends Node

var path = "user://data.json"

# The default values
var default_data = {
	"player" : {
		"name" : "Jamie",
		"level" : 3,
		"health" : 10
		},
	"options" : {
		"music_volume" : 0.5,
		"cheat_mode" : false
		},
	"levels_completed" : [1, 2, 3]
}

var data = { }


func _ready():
	load_game()
	update_text()


func load_game():
	var file = File.new()
	
	if not file.file_exists(path):
		reset_data()
		return
	
	file.open(path, file.READ)
	
	var text = file.get_as_text()
	
	data = parse_json(text)
	
	
	file.close()


func save_game():
	var file
	
	file = File.new()
	
	file.open(path, File.WRITE)
	
	file.store_line(to_json(data))
	
	file.close()


func reset_data():
	# Reset to defaults
	data = default_data.duplicate(true)


func add_health(amount : int):
	data["player"]["health"] += amount


func update_text():
	find_node("DataText").text = JSON.print(data)


func _on_SaveButton_pressed():
	save_game()


func _on_LoadButton_pressed():
	load_game()
	update_text()


func _on_DeleteButton_pressed():
	# Delete file
	var dir = Directory.new()
	dir.remove(path)
	
	reset_data()
	
	update_text()


func _on_AddHealthButton_pressed():
	add_health(-1)
	update_text()
