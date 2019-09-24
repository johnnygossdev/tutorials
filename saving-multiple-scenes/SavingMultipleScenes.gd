extends Node

onready var current_room = null


var roomA = load("res://RoomA.tscn")
var roomB = load("res://RoomB.tscn")


func _ready():
	
	change_room(roomA)


func change_room(room_scene : PackedScene):
	
	if current_room:
		current_room.queue_free()
		yield(current_room, "tree_exited")
	
	var new_room = room_scene.instance()
	
	current_room = new_room
	
	add_child(new_room)


func _on_ButtonRoomA_pressed():
	
	current_room.save_room()
	
	change_room(roomA)


func _on_ButtonRoomB_pressed():
	
	current_room.save_room()
	
	change_room(roomB)


func _on_ButtonDeleteSave_pressed():
	
	delete_save_data()
	
	get_tree().reload_current_scene()


func delete_save_data():
	"""
	Adapted from:
		https://godotengine.org/qa/5175/how-to-get-all-the-files-inside-a-folder
	"""
	
	var dir = Directory.new()
	
	dir.open("user://")
	
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			dir.remove(file)

	dir.list_dir_end()


func _on_ButtonManualSave_pressed():
	
	if current_room:
		current_room.save_room()
