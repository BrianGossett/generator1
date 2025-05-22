extends RigidBody2D

var team: String = "blue";


func _ready():
	apply_team_color()

func apply_team_color():
	match team:
		"blue":
			$Sprite2D.modulate = Color(0.0, 0.5, 1.0)
		"red":
			$Sprite2D.modulate = Color(1.0, 0.2, 0.2)

func configure(team_name: String, bounce_value: float, gravity: float):
	team = team_name
	gravity_scale = gravity
	$CollisionShape2D.material_override.bounce = bounce_value
	apply_team_color()
