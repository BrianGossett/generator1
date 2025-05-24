extends ColorRect

@onready var fill = $InnerBox
@onready var outline = self

@export var team: int = -1  # -1 = neutral, 0 = red, 1 = blue

const COLORS = {
	-1: Color.BLACK,
	0:Color("4b6aff") ,  # red
	1:   Color("ff4b4b") # blue
}

const OUTLINES = {
	-1: Color.WHITE,
	0: Color("2b3c99") ,  # dark red
	1:Color("a03333")   # dark blue
}

func _ready():
	update_colors()

func set_team(new_team: int):
	if new_team != team:
		team = new_team
		update_colors()

func update_colors():
	fill.color = COLORS.get(team, Color.BLACK)
	outline.color = OUTLINES.get(team, Color.WHITE)


func _on_box_area_body_entered(body: Node2D) -> void:
	if(body.get_groups().has("Orb")):
		if (body.team != team):
			team = body.team
			update_colors()
			body.queue_free()
