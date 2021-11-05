extends KinematicBody2D

export var speed = 800

onready var x_position = position.x
onready var velocity = Vector2(0,0) 

func _ready():	
	hide()

func _physics_process(delta):
	# Keyboard
	if Input.is_action_pressed("ui_down") or Input.is_key_pressed(KEY_S):
		velocity.y = speed
	elif Input.is_action_pressed("ui_up") or Input.is_key_pressed(KEY_W):
		velocity.y = -speed
	else:
		velocity.y = 0
		
	var collision = move_and_collide(velocity * delta)
	if collision:
		# correct some collisions offsetting x position by few pixels
		position.x = x_position
