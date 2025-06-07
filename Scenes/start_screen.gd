extends Control



func _on_start_button_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/play_area.tscn")  # replace with your game scene path

func _on_look_thing_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/test_bed.tscn") 

func _on_free_for_all_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/play_area_free_four.tscn") 

func _on_quit_button_down() -> void:
	get_tree().quit()


func _on_options_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/options.tscn") 


func _on_v_2_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/play_area_6.tscn") 
