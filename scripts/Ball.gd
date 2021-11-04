extends KinematicBody2D

signal hit_paddle
signal out_of_bounds

export var speed = 800
var velocity

func _ready():
	hide()
	velocity = Vector2(0,0)
	
func serve(pos):
	hide()
	position = pos
	show()
	var direction = choose_initial_direction()
	velocity = direction * speed
	
func choose_initial_direction():
	var random_up = (randi() % 11) + 195
	var random_down = (randi() % 11) + 155
	var degree_angle = random_up if randi() % 2 == 0  else random_down
	var angle = deg2rad((degree_angle))
	return Vector2(cos(angle), sin(angle))

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.collider.is_in_group("paddles"):
			emit_signal("hit_paddle")
		velocity = velocity.bounce(collision.normal)
		
func _on_VisibilityNotifier2D_screen_exited():
	# queue_free() not needed because not spawning new ball
	emit_signal("out_of_bounds")
