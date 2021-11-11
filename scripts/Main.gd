extends CanvasLayer

func _ready():	
	randomize()
	
func _on_PracticeButton_pressed():
	get_tree().change_scene("res://scenes/Practice.tscn")

func _on_PvPButton_pressed():
	get_tree().change_scene("res://scenes/PvP.tscn")


func _on_PvEButton_pressed():
	get_tree().change_scene("res://scenes/PvE.tscn")


func _on_EvEButton_pressed():
	get_tree().change_scene("res://scenes/EvE.tscn")
