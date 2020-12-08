extends Area2D

"""
When clicked on,
can be moved around the screen
"""

var previous_mouse_position = Vector2()
var is_dragging = false


func _on_Draggable_input_event(viewport, event, shape_idx):
	
	"""
	Allows dragging if the user clicks inside
	the collision shape
	"""
	
	if event.is_action_pressed("ui_touch"):
		print(event)
		get_tree().set_input_as_handled()
		previous_mouse_position = event.position
		is_dragging = true


func _input(event):
	
	"""
	Works globally so dragging works if
	mouse cursor is outside of Collision Shape
	Disables dragging if the user releases click
	"""
	
	if not is_dragging:
		return
	
	if event.is_action_released("ui_touch"):
		previous_mouse_position = Vector2()
		is_dragging = false
	
	
	if is_dragging and event is InputEventMouseMotion:
		position += event.position - previous_mouse_position
		previous_mouse_position = event.position
