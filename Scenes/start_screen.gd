extends Control

@onready var start_button = $VBoxContainer/StartButton
@onready var quit_button = $VBoxContainer/Quit


func _on_start_button_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/play_area.tscn")  # replace with your game scene path


func _on_quit_button_down() -> void:
	get_tree().quit()


func _on_look_thing_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/test_bed.tscn") 
