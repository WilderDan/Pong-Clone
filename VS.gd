extends Node

enum {LEFT, RIGHT}

onready var leftScore = 0
onready var rightScore = 0
#onready var screenWidth = get_viewport_rect().size.x
#var playerToScore

func _on_HUD_start_game():
	updateScore(LEFT, 0)
	updateScore(RIGHT, 0)
	$LeftPaddle.position = $LeftPaddlePosition.position
	$LeftPaddle.show()
	$RightPaddle.position = $RightPaddlePosition.position
	$RightPaddle.show()
	var side = LEFT if randi() % 2 == 0 else RIGHT
	serveBall(side)

func serveBall(side):
	$ServeTimer.start(1)
	yield($ServeTimer, "timeout")
	if side == LEFT:
		$Ball.serve($LeftServePosition.position)
		#playerToScore = RIGHT
	else:
		$Ball.serve($RightServePosition.position)
		$Ball.velocity.x = -$Ball.velocity.x
		#playerToScore = LEFT

func updateScore(side, value):
	if side == LEFT:
		leftScore = value
		$HUD/Mode/Score.text = str(leftScore)
	else:
		rightScore = value
		$HUD/Mode/Score2.text = str(rightScore)
		
func _on_Ball_out_of_bounds():
	if $Ball.position.x < 0:
		updateScore(RIGHT, rightScore + 1)
		if rightScore < 10:
			serveBall(LEFT)
	else:
		updateScore(LEFT, leftScore + 1)
		if leftScore < 10:
			serveBall(RIGHT)
		
	if leftScore == 10 or rightScore == 10:
		gameOver()
		

func _on_Ball_hit_paddle():
	$BallHit.play()
	# Switch to current player who stands to gain a point
	#playerToScore = LEFT if playerToScore == RIGHT else RIGHT

func gameOver():
	$Ball.velocity = Vector2(0,0)
	$LeftPaddle.hide()
	$RightPaddle.hide()
	$Gameover.play()
	$HUD/Mode/Background.show()
	$HUD/Mode/VBoxContainer.show()
