extends RigidBody2D

@export var team: int = 0
@export var gravity: float = 0
@onready var trail: Line2D = $Trail
const TRAIL_LENGTH := 15  # Max number of trail points

var trail_points: Array = []


func _process(_delta: float) -> void:
	# Track orb position and update trail
	trail_points.push_front(global_position)
	trail.position = -global_position  # Keep trail globally aligned

	if trail_points.size() > TRAIL_LENGTH:
		trail_points.pop_back()

	trail.clear_points()
	for point in trail_points:
		trail.add_point(point)


func configure(team_id: int, bounciness: float = 1.0) -> void:
	team = team_id

	var material := PhysicsMaterial.new()
	material.bounce = bounciness
	material.friction = 0
	physics_material_override = material

	set_linear_damp_mode(1)
	gravity_scale = gravity
	linear_damp = 0
	angular_damp = 0
	rotation = 0

	update_visual()


func update_visual() -> void:
	var color = GameInfo.team_color(team)
	$OrbColor.color = color
	color.a = 0.4
	trail.default_color = color

func launch(start_position: Vector2, direction: Vector2, force: float, team_id: int, bounciness: float = 1.0) -> void:
	global_position = start_position
	configure(team_id, bounciness)
	call_deferred("apply_central_impulse", direction.normalized() * force)

func launch_random( team_id: int, force: float = 400.0, bounciness: float = 1.0) -> void:
	configure(team_id, bounciness)
	$Timer.stop()

	var random_angle = randf() * TAU  # Random angle 0 to 2π
	var direction = Vector2.RIGHT.rotated(random_angle)
	call_deferred("apply_central_impulse", direction * force)

func _on_timer_timeout() -> void:
	queue_free()
