extends Node

var score
	
func _on_HUD_start_game():
	score = 0
	update_score(0)
	$Ball.serve($ServePosition.position)
	$Paddle.position = $LeftPaddlePosition.position
	$Paddle.show()

func update_score(value):
	score = value
	$HUD/Score.text = str(score)

func _on_Ball_hit_paddle():
	update_score(score + 1)
	$BallHit.play()

func _on_Ball_out_of_bounds():
	$Gameover.play()
	update_score(0)
	$Ball.serve($ServePosition.position)

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://scenes/Main.tscn")
