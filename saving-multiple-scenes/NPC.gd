extends Position2D
class_name NPC

export var speed = 100
export var direction = Vector2(1, 0)

func _physics_process(delta):
	
	position += direction * speed * delta

func save():
    var save_dict = {
        "filename" : get_filename(),
        "parent" : get_parent().get_path(),
        "pos_x" : position.x, # Vector2 is not supported by JSON
        "pos_y" : position.y,
        "speed" : speed,
        "direction_x" : direction.x,
        "direction_y" : direction.y
    }
    return save_dict

func _on_Area2D_input_event(viewport, event, shape_idx):
	
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			queue_free()
