extends Node2D

var dust_scene = preload("res://Dust.tscn")

func _ready():
	$AnimationPlayer.play("bounce")

func _process(delta):
	position.x += 240*delta

func create_impact_dust():
	# -- New function in fewer lines
	# Note it isn't optimal because it creates a dust scene
	# with 0 scale
	
	# Update 01/09/2019: made dust position independent
	# of ball
	var dust_position = global_position + Vector2(0, 40)
	var dust

	for _i in range(-2, 3):
		dust = dust_scene.instance()
		dust.position = dust_position
		dust.scale.x *= _i/2.0
		dust.scale.y *= abs(_i/2.0)
		get_parent().add_child(dust)

#	-- Old Function 
#	
#	var dust_position = Vector2(0, 40)
#	var dust = dust_scene.instance()
#	dust.position = dust_position
#	add_child(dust)
#
#	dust = dust_scene.instance()
#	dust.scale = Vector2(-1, 1)
#	dust.position = dust_position
#	add_child(dust)
#
#	dust = dust_scene.instance()
#	dust.scale = Vector2(0.5, 0.5)
#	dust.position = dust_position
#	add_child(dust)
#
#	dust = dust_scene.instance()
#	dust.scale = Vector2(-0.5, 0.5)
#	dust.position = dust_position
#	add_child(dust)
