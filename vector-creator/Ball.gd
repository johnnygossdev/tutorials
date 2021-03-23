extends RigidBody2D


func _ready():
	set_bounce(0.5)
	set_friction(0.2)

func launch(force : Vector2) -> void:
	
	apply_impulse(Vector2.ZERO, force)
	
