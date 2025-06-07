extends Node2D
@onready var gen1 = $GenLeftTop
@onready var gen2 = $GenLeftMiddle
@onready var gen3 = $GenLeftBottom
@onready var gen4 = $GenRightTop
@onready var gen5 = $GenRightMiddle
@onready var gen6 = $GenRightBottom


@onready var screen_fade = $ScreenFade
@onready var vicotry_label = $Label


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		GameInfo.set_defult()
		get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")

func _ready() -> void:
	$field2.apply_box_grid($field2.generate_grid_from_zones({
		"top_left": 0,
		"top_right": 1,
		"mid_left": 2,
		"mid_right": 3,
		"bot_left": 4,
		"bot_right": 6,
	}))
	gen1.BallSpawn(2)
	gen2.BallSpawn(2)
	gen3.BallSpawn(2)
	gen4.BallSpawn(2)
	gen5.BallSpawn(2)
	gen6.BallSpawn(2)

func fade_to_color(color: Color, duration := 1.5):
	screen_fade.color = Color(0, 0, 0, 0)
	vicotry_label.visible = true
	vicotry_label.modulate = color
	screen_fade.visible = true
	$Like.visible = true
	$Like.add_theme_color_override("font_color", color)
	var tween = create_tween()
	tween.tween_property(screen_fade, "color:a", 1.0, duration)

func _process(_delta) -> void:
	checkWin()


func _on_timer_timeout() -> void:
	if GameInfo.victory_value[gen1.team]:
		gen1.BallSpawn(1)
	if GameInfo.victory_value[gen2.team]:
		gen2.BallSpawn(1)
	if GameInfo.victory_value[gen3.team]:
		gen3.BallSpawn(1)
	if GameInfo.victory_value[gen4.team]:
		gen4.BallSpawn(1)
	if GameInfo.victory_value[gen5.team]:
		gen5.BallSpawn(1)
	if GameInfo.victory_value[gen6.team]:
		gen6.BallSpawn(1)



func checkWin():
	if GameInfo.has_winner:
		return

	var valid_teams = [0, 2, 3, 1, 4, 6]
	var remaining_teams = []

	for team in valid_teams:
		if GameInfo.victory_value[team]:
			remaining_teams.append(team)

	if remaining_teams.size() == 1:
		GameInfo.has_winner = true
		var winning_team = remaining_teams[0]
		fade_to_color(GameInfo.team_color(winning_team), 3)
