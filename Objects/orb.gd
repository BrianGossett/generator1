extends RigidBody2D

@export var team: int = 0

const TEAM_COLORS = {
	0:Color("2b3c99"),
	1:Color("a03333")  
}

func configure(team_id: int, bounciness: float = 1.0):
	team = team_id
	self.physics_material_override = PhysicsMaterial.new()
	self.physics_material_override.bounce = bounciness
	self.gravity_scale = 0
	update_visual()

func update_visual():
	var color = TEAM_COLORS.get(team, Color.GRAY)
	$OrbColor.color = color


func _on_timer_timeout() -> void:
	self.queue_free()
