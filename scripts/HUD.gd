extends CanvasLayer

signal start_game

func _on_Start_pressed():
	$Menu.hide()
	emit_signal("start_game")


func _on_Main_Menu_Button_pressed():
	get_tree().change_scene("res://sceens/Main.tscn")
