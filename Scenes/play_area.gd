extends Node2D
@onready var gen1 = $GeneratorTeam0
@onready var gen2 = $GeneratorTeam1


@onready var screen_fade = $ScreenFade
@onready var vicotry_label = $Label


var has_winner := false

func _ready() -> void:
	$Field.generate_grid_from_corners({
		"bottom_left": 0,
		"bottom_right": -1,
		"top_left": -1,
		"top_right": 1
	})

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
	gen1.BallSpawn(2)
	gen2.BallSpawn(2)



func checkWin():
	if has_winner:
		return
	if !GameInfo.victory_value[0]:
		has_winner = true
		fade_to_color(GameInfo.team_color(0), 3)
	elif !GameInfo.victory_value[1]:
		has_winner = true
		fade_to_color(GameInfo.team_color(1), 3)
