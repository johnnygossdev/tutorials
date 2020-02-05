tool
extends RichTextEffect
class_name RichTextHover

"""
Adapted from
https://docs.godotengine.org/en/latest/tutorials/gui/bbcode_in_richtextlabel.html
"""

var bbcode := "hover"

func _process_custom_fx(char_fx):
	
	var speed = char_fx.env.get("speed", 5.0)

	var offset := Vector2(0, sin(char_fx.elapsed_time * speed))
	char_fx.offset = offset
	return true
