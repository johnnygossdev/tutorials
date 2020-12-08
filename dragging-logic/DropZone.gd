extends Area2D

"""
Removes any overlapping Area2Ds
on user click up 
"""

func _input(event):
	
	if event.is_action_released("ui_touch"):
		for _a in get_overlapping_areas():
			_a.queue_free()
