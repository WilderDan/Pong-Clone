extends CanvasLayer

func _ready():	
	randomize()
	
func _on_PracticeButton_pressed():
	get_tree().change_scene("res://scenes/Practice.tscn")

func _on_VS_Button_pressed():
	get_tree().change_scene("res://scenes/VS.tscn")
