extends KinematicBody2D

export var speed = 800

# screen height - border thickness - height
export var upper_bounds = 10
export var lower_bounds = 698

onready var x_position = position.x
onready var height = $ColorRect.rect_size.y
onready var velocity = Vector2(0,0) 
onready var is_touch_move = false
onready var touch_area = get_viewport_rect().size.x / 3

var touch_target

func _input(event):
	if event is InputEventScreenTouch and event.pressed:
			touch_target = event.position
			if (touch_target.x <= touch_area):
				is_touch_move = true

func _physics_process(delta):
	# Mouse Click / Touch
	if is_touch_move:
		if abs(touch_target.y - position.y - height/2) > 30:
			velocity.y = touch_target.y - position.y 
			velocity = velocity.normalized() * speed * 3
		else:
			velocity = Vector2(0,0)
			position.y = touch_target.y - height/2
			position.y = clamp(position.y, upper_bounds, lower_bounds)
			is_touch_move = false
			
	# Keyboard
	elif Input.is_action_pressed("ui_down"):
		velocity.y = speed
	elif Input.is_action_pressed("ui_up"):
		velocity.y = -speed
	else:
		velocity.y = 0
		
	var collision = move_and_collide(velocity * delta)
	if collision:
		# correct some collisions offsetting x position by few pixels
		position.x = x_position
