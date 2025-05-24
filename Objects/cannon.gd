extends Node2D


@export var team: int = 0;
@export var rotation_speed: float = 1.0  # Controls speed of sweep
@export var arc_angle_deg: float = 90.0  # Total arc in degrees
@export var orb_scene: PackedScene = preload('res://Objects/orb.tscn') # assign res://Objects/ball.tscn in the Inspector


@onready var base: ColorRect = $Base;
@onready var pipe: ColorRect = $Pipe;

var angle_offset := 0.0

func _ready():
	apply_team_color()
	
	GameInfo.fire_value[team] = 100

func apply_team_color():
	var color = GameInfo.team_color(team);
	base.color = color;
	pipe.color = color;

func _process(delta):
	angle_offset += delta * rotation_speed
	var angle_rad = deg_to_rad(arc_angle_deg / 2.0) * sin(angle_offset)
	rotation = angle_rad



func emit_orb():
	var orb = orb_scene.instantiate()
	var direction = global_transform.x.normalized()
	orb.position = $Fire_Point.global_position
	get_tree().current_scene.add_child(orb)
	orb.configure(team, 1)
	orb.call_deferred("apply_central_impulse", direction * 400)


func _on_shoot_timer_timeout() -> void:
	if GameInfo.fire_value[team] > 0:
		emit_orb()
		GameInfo.fire_value[team] -= 1
