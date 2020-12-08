extends Area2D

export var group := "dragable"

var _touch_position := Vector2.ZERO
var _dragging := false

onready var _sprite := $Sprite


func _ready() -> void:
	add_to_group(group)


func _input(event) -> void:
	if not _dragging:
		return
	
	if event.is_action_released("ui_touch"):
		_dragging = false
	
	if event is InputEventMouseMotion:
		position -= _touch_position - (event.position)
		_touch_position = event.position


func _on_input_event(_viewport, event, _shape_idx) -> void:
	if event.is_action_pressed("ui_touch"):
		if _is_on_top():
			_dragging = true
			_touch_position = event.position


func _is_on_top() -> bool:
	
	for dragable in get_tree().get_nodes_in_group(group + "hovered"):
		if dragable.get_index() > get_index():
			return false
	
	return true


func _on_mouse_entered() -> void:
	add_to_group(group + "hovered")


func _on_mouse_exited() -> void:
	remove_from_group(group + "hovered")
