extends Node

var floaty_text_scene = preload("res://FloatingText.tscn")


func _on_CreateFloatingTextButton_pressed():
	var floaty_text = floaty_text_scene.instance()
	
	floaty_text.position = Vector2(480/2, 270/2)
	floaty_text.velocity = Vector2(rand_range(-50, 50), -100)
	floaty_text.modulate = Color(rand_range(0.7, 1), rand_range(0.7, 1), rand_range(0.7, 1), 1.0)
	
	### White
	#floaty_text.modulate = Color(1.0, 1.0, 1.0, 1.0)
	
	floaty_text.text = randi()%2000 - 1000
	
	add_child(floaty_text)
