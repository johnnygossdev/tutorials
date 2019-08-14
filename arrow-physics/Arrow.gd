extends Area2D

export var mass = 2.0

var launched = false
var velocity = Vector2(0, 0)

func _ready():
	pass 


func _process(delta):
	
	if launched:
		# Update: delta is also needed here
		velocity += gravity_vec*gravity*mass*delta
		
		position += velocity*delta
		
		rotation = velocity.angle()


func launch(initial_velocity : Vector2):
	launched = true
	velocity = initial_velocity
