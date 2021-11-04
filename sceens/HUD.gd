extends CanvasLayer

signal start_game

func _on_Start_pressed():
	$Menu.hide()
	emit_signal("start_game")
