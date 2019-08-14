extends Node2D

func _ready():
	find_node("Arrow").launch(Vector2(randf(), -randf())*200)


func _on_ResetButton_pressed():
	get_tree().reload_current_scene()

