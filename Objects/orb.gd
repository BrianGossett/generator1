extends RigidBody2D

@export var team: int = 0

@onready var trail: Line2D = $Trail
const TRAIL_LENGTH := 15  # Max number of points in the trail

var queue: Array

func _process(delta):
	var pos = global_position
	
	queue.push_front(pos)
	trail.position = -1* global_position
	
	if queue.size() > TRAIL_LENGTH:
		queue.pop_back()
	
	trail.clear_points()
	
	for  point in queue:
		trail.add_point(point)

func configure(team_id: int, bounciness: float = 1.0):
	print_debug('config',trail.position,trail.global_position)
	team = team_id
	self.physics_material_override = PhysicsMaterial.new()
	self.physics_material_override.bounce = bounciness
	self.physics_material_override.friction = 0
	set_linear_damp_mode(1)
	rotation = 0
	gravity_scale = 0
	linear_damp = 0
	angular_damp = 0
	update_visual()

func update_visual():
	var color = GameInfo.team_color(team)
	$OrbColor.color = color
	$Trail.default_color = Color(color.r, color.g, color.b, .4)


func _on_timer_timeout() -> void:
	self.queue_free()
