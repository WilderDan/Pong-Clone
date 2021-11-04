extends Node

var score

func _ready():	
	randomize()
	
func _on_HUD_start_game():
	score = 0
	update_score(0)
	$Ball.serve($ServePosition.position)

func update_score(value):
	score = value
	$HUD/Score.text = str(score)

func _on_Ball_hit_paddle():
	update_score(score + 1)
	$BallHit.play()

func _on_Ball_out_of_bounds():
	$Ball.velocity = Vector2(0,0)
	$Gameover.play()
	$HUD/Menu.show()
