extends RigidBody2D

@export var team: int = 0;
@onready var colorRect: ColorRect = $BallView;

func _ready():
	apply_team_color()

func apply_team_color():
	colorRect.color = GameInfo.team_color(team);

func configure(team_name: int, bounce_value: float, gravity: float):
	team = team_name
	gravity_scale = gravity
	self.physics_material_override.bounce = bounce_value
