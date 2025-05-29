extends Node2D
@onready var gen1 = $GeneratorTeam0
@onready var gen2 = $GeneratorTeam1


@onready var screen_fade = $ScreenFade
@onready var vicotry_label = $Label

@export var team_layout := {
		"bottom_left": 0,
		"bottom_right": -1,
		"top_left": -1,
		"top_right": 1
	}

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		GameInfo.set_defult()
		get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")


func _ready() -> void:
	$Field.apply_box_grid($Field.generate_grid_from_corners(team_layout))
	gen1.BallSpawn(6)
	gen2.BallSpawn(6)

func fade_to_color(color: Color, duration := 1.5):
	screen_fade.color = Color(0, 0, 0, 0)
	vicotry_label.visible = true
	vicotry_label.add_theme_color_override("font_color",color)
	screen_fade.visible = true
	var tween = create_tween()
	tween.tween_property(screen_fade, "color:a", 1.0, duration)

func _process(_delta) -> void:
	checkWin()


func _on_timer_timeout() -> void:
	if GameInfo.victory_value[gen1.team]:
		gen1.BallSpawn(2)
	if GameInfo.victory_value[gen2.team]:
		gen2.BallSpawn(2)



func checkWin():
	if GameInfo.has_winner:
		return

	var valid_teams = [0, 1]
	var remaining_teams = []

	for team in valid_teams:
		if GameInfo.victory_value[team]:
			remaining_teams.append(team)

	if remaining_teams.size() == 1:
		GameInfo.has_winner = true
		var winning_team = remaining_teams[0]
		fade_to_color(GameInfo.team_color(winning_team), 3)
