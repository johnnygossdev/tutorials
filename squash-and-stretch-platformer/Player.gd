extends KinematicBody2D
"""
Basic platformer control from Heartbeast 
for the purpose of showing Squash and Stretch
	https://www.youtube.com/watch?v=wETY5_9kFtA
Other platformers are available
"""

const UP = Vector2(0, -1)
const GRAVITY = 35
const SPEED = 700
const JUMP_HEIGHT = -1200

var motion = Vector2()
var motion_previous = Vector2()

var hit_the_ground = false

func _physics_process(delta):
	motion.y += GRAVITY
	
	
	if Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
	elif Input.is_action_pressed("ui_right"):
		motion.x = SPEED
	else:
		motion.x = 0
	
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
	
	
	motion_previous = motion
	motion = move_and_slide(motion, UP, false)
	
	
	"""
	-- New Code from this Point --
	If the player is in the air, make scale of sprite
	based on the y motion value using range_lerp
	The fast the y motion, 
	the larger the y stretch, 
	the larger the x squash
	"""
	
	if not is_on_floor():
		hit_the_ground = false
		$Sprite.scale.y = range_lerp(abs(motion.y), 0, abs(JUMP_HEIGHT), 0.75, 1.75)
		$Sprite.scale.x = range_lerp(abs(motion.y), 0, abs(JUMP_HEIGHT), 1.25, 0.75)
	
	"""
	If there's a floor collision,
	set squashed scale values based on
	previous motion
	"""
	
	if not hit_the_ground and is_on_floor():
		hit_the_ground = true
		$Sprite.scale.x = range_lerp(abs(motion_previous.y), 0, abs(1700), 1.2, 2.0)
		$Sprite.scale.y = range_lerp(abs(motion_previous.y), 0, abs(1700), 0.8, 0.5)
	
	
	"""
	lerp function eases sprite scale to default position
	See article on using delta with lerp:
		https://www.construct.net/en/blogs/ashleys-blog-2/using-lerp-delta-time-924
	"""
	
	$Sprite.scale.x = lerp($Sprite.scale.x, 1, 1 - pow(0.01, delta))
	$Sprite.scale.y = lerp($Sprite.scale.y, 1, 1 - pow(0.01, delta))