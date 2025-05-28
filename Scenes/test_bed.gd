extends Node2D

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		GameInfo.set_defult()
		get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")

func _ready() -> void:
	$Orb.launch_random(0)
	$Orb2.launch_random(1)
	$Orb3.launch_random(2)
	$Orb4.launch_random(3)
	$Orb5.launch_random(4)
	$Orb6.launch_random(5)
	$Orb7.launch_random(6)
	$Orb8.launch_random(7)
	$Orb9.launch_random(8)
	$Orb10.launch_random(9)
