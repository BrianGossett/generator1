extends ColorRect

@onready var fill = $InnerBox
@onready var outline = self

@export var team: int = -1  # -1 = neutral, 0 = red, 1 = blue
@export var victory: bool = false

func _ready():
	update_colors()

func set_team(new_team: int):
	if new_team != team:
		team = new_team
		update_colors()

func set_victory(new_victory: bool):
	victory = new_victory
	update_colors()

func update_colors():
	fill.color = GameInfo.team_box_color(team)
	if victory:
		outline.color = Color.GOLD
	else:
		outline.color = GameInfo.team_outline_color(team)


func _on_box_area_body_entered(body: Node2D) -> void:
	if(body.get_groups().has("Orb")):
		if (body.team != team):
			team = body.team
			update_colors()
			if (victory):
				GameInfo.victory_value[team] = false
			body.queue_free()
