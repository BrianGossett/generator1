extends Node2D
@onready var gen1 = $GeneratorTeam0
@onready var gen2 = $GeneratorTeam1


@onready var screen_fade = $ScreenFade
@onready var fade_tween = get_tree().create_tween()


var has_winner := false

func fade_to_color(color: Color, duration := 1.5):
	screen_fade.color = Color(color.r, color.g, color.b, 0)
	screen_fade.visible = true
	var tween = create_tween()
	tween.tween_property(screen_fade, "color:a", 1.0, duration)
	tween.tween_callback(Callable(self, "_on_fade_complete"))

func _physics_process(delta: float) -> void:
	checkWin()

func _on_fade_complete():
	get_tree().paused = true


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
