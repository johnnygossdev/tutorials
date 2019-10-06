extends Position2D


func _ready():
	load_room()


func load_room():
	"""
	Addapted from:
		https://docs.godotengine.org/en/3.1/tutorials/io/saving_games.html
	"""
	var save_game = File.new()
	if not save_game.file_exists("user://" + name + ".save"):
		return # Error! We don't have a save to load.

    # We need to revert the game state so we're not cloning objects
    # during loading. This will vary wildly depending on the needs of a
    # project, so take care with this step.
    # For our example, we will accomplish this by deleting saveable objects.
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		i.queue_free()

    # Load the file line by line and process that dictionary to restore
    # the object it represents.
	save_game.open("user://" + name + ".save", File.READ)
   
	while not save_game.eof_reached():
		var current_line = parse_json(save_game.get_line())
		
		"""
		Lines 37 & 38 are not in the documentation as of 03/10/19.
		They are necessary to avoid a null error. See:
			https://godotengine.org/qa/16807/godot-3-base-nill-while-parsing-json-file
		"""
		if current_line == null:
			continue
		
        # Firstly, we need to create the object and add it to the tree and set its position.
		var new_object = load(current_line["filename"]).instance()
		get_node(current_line["parent"]).add_child(new_object)
		new_object.position = Vector2(current_line["pos_x"], current_line["pos_y"])
		new_object.direction = Vector2(current_line["direction_x"], current_line["direction_y"])
        
		# Now we set the remaining variables.
		for i in current_line.keys():
			if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y" or i == "direction_x" or i == "direction_y":
				continue
			new_object.set(i, current_line[i])
	
	save_game.close()

func save_room():
	var save_game = File.new()
	save_game.open("user://" + name + ".save", File.WRITE)
	
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	
	for i in save_nodes:
		var node_data = i.call("save");
		save_game.store_line(to_json(node_data))
	
	save_game.close()