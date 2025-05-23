extends RigidBody2D

var team: String = "blue";
@onready var colorRect: ColorRect = $BallView;

func _ready():
	apply_team_color()

func apply_team_color():
	match team:
		"blue":
			colorRect.color = Color(0.0, 0.5, 1.0)
		"red":
			colorRect.color = Color(1.0, 0.2, 0.2)

func configure(team_name: String, bounce_value: float, gravity: float):
	team = team_name
	gravity_scale = gravity
	$CollisionShape2D.material_override.bounce = bounce_value
	apply_team_color()
