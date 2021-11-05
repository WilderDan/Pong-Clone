extends KinematicBody2D

export var id = 1
export var speed = 600

onready var x_position = position.x
onready var velocity = Vector2(0,0) 

func _ready():	
	hide()

func _physics_process(delta):
	# Keyboard
	if Input.is_action_pressed('down_%s' % id):
		velocity.y = speed
	elif Input.is_action_pressed('up_%s' % id):
		velocity.y = -speed
	else:
		velocity.y = 0
		
	var collision = move_and_collide(velocity * delta)
	if collision:
		# correct some collisions offsetting x position by few pixels
		position.x = x_position
