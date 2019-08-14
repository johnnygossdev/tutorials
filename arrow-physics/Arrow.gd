extends Area2D

export var mass = 0.25

var launched = false
var velocity = Vector2(0, 0)

func _ready():
	pass 


func _process(delta):
	
	if launched:
		velocity += gravity_vec*gravity*mass
		
		position += velocity*delta
		
		rotation = velocity.angle()


func launch(initial_velocity : Vector2):
	launched = true
	velocity = initial_velocity
