extends Node2D
@onready var gen1 = $GeneratorTopLeft
@onready var gen2 = $GeneratorTopRight
@onready var gen3 = $GeneratorBottomLeft
@onready var gen4 = $GeneratorBottomRight


@onready var screen_fade = $ScreenFade
@onready var vicotry_label = $Label



func _ready() -> void:
	$Field.apply_box_grid($Field.generate_grid_from_corners({
		"bottom_left": 2,
		"bottom_right": 6,
		"top_left": 0,
		"top_right": 3
	}))

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
	gen1.BallSpawn(1)
	gen2.BallSpawn(1)
	gen3.BallSpawn(1)
	gen4.BallSpawn(1)



func checkWin():
	if GameInfo.has_winner:
		return

	var valid_teams = [0, 2, 3, 6]
	var remaining_teams = []

	for team in valid_teams:
		if GameInfo.victory_value[team]:
			remaining_teams.append(team)

	if remaining_teams.size() == 1:
		GameInfo.has_winner = true
		var winning_team = remaining_teams[0]
		fade_to_color(GameInfo.team_color(winning_team), 3)
