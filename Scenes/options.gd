extends Control

@onready var menu := $VBoxContainer/MenuButton

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")

func _ready():
	var popup = menu.get_popup()
	popup.id_pressed.connect(file_menu)

func file_menu(id):
	menu.text = String(id)

func _on_primary_button_color_changed(color: Color) -> void:
	pass # Replace with function body.


func _on_box_button_color_changed(color: Color) -> void:
	pass # Replace with function body.


func _on_outline_buttons_color_changed(color: Color) -> void:
	pass # Replace with function body.


func _on_menu_button_button_down() -> void:
	pass
