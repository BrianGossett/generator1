extends Node2D


@export var team: int = 0;
@export var rotation_speed: float = 1.0  # Controls speed of sweep
@export var arc_angle_deg: float = 90.0  # Total arc in degrees
@export var orb_scene: PackedScene = preload('res://Objects/orb.tscn') # assign res://Objects/ball.tscn in the Inspector

var angle_offset := 0.0
var base_rotation := 0.0

@onready var base: ColorRect = $Base;
@onready var pipe: ColorRect = $Pipe;


func _ready():
	apply_team_color()
	base_rotation = rotation 

func apply_team_color():
	var color = GameInfo.team_color(team);
	base.color = color;
	pipe.color = color;

func _process(delta):
	angle_offset += delta * rotation_speed
	var angle_rad = deg_to_rad(arc_angle_deg / 2.0) * sin(angle_offset)
	rotation = base_rotation + angle_rad



func emit_orb(number):
	for i in range(number):
		var orb = orb_scene.instantiate()
		var direction = global_transform.x.normalized()
		orb.position = $Fire_Point.global_position
		get_tree().current_scene.add_child(orb)
		orb.configure(team, 1)
		orb.call_deferred("apply_central_impulse", direction * 400)
		GameInfo.fire_value[team] -= 1
		await get_tree().create_timer(0.02).timeout



func _on_shoot_timer_timeout() -> void:
	if GameInfo.fire_value[team] > 0:
		if GameInfo.fire_value[team] > 100:
			emit_orb(5)
		else:
			emit_orb(1)
