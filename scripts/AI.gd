extends KinematicBody2D

export var speed = 600
export var error = 30
export var isFastReact = false

onready var x_position = position.x
onready var velocity = Vector2(0,0) 
onready var height = $ColorRect.rect_size.y
onready var ball = get_node("../Ball")
onready var initialSpeed = ball.speed
onready var targetPosition = position
onready var screenSize = get_viewport_rect().size
#onready var lowPoint = screenSize.y - height - 10

func _ready():	
	hide()

func _physics_process(delta):
	# Determine target position
	if ball.position.x < 0 or ball.position.x > screenSize.x:
		targetPosition.y = (screenSize.y / 2) - height/2
	elif isFastReact or abs(ball.position.x - position.x) < screenSize.x/2:
		var randomError = (randi() % error) * (ball.speed / initialSpeed)
		var deltaModifier = ball.velocity.y * delta
		
		if ball.velocity.y < 0:
			randomError *= -1
			
		targetPosition.y = ball.position.y + deltaModifier + randomError
	else:
		targetPosition.y = (screenSize.y / 2) - height/2
		
	if abs(position.y - targetPosition.y) > height/4:
		velocity = targetPosition - position
		velocity = velocity.normalized() * speed
	else:
		velocity = Vector2(0,0)
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		# correct some collisions offsetting x position by few pixels
		position.x = x_position
