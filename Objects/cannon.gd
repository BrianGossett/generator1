extends Node2D


@export var team: int = 0;
@export var rotation_speed: float = 0.25  # Controls speed of sweep
@export var arc_angle_deg: float = 100.0  # Total arc in degrees
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

	var t := fmod(angle_offset, 1.0)
	var tri_wave = abs(2.0 * t - 1.0)  # triangle wave between 0 and 1
	var angle_rad = deg_to_rad(arc_angle_deg / 2.0) * (1.0 - tri_wave * 2.0)

	rotation = base_rotation + angle_rad

func emit_orb(number: int, time: float, angle_spread: float = 0.0):
	for i in range(number):
		var orb = orb_scene.instantiate()
		get_tree().current_scene.add_child(orb)

		var direction = global_transform.x.normalized()
		var fire_angle_offset = randf_range(-angle_spread, angle_spread)
		var randomized_direction = direction.rotated(fire_angle_offset)

		orb.launch(
			$Fire_Point.global_position,
			randomized_direction,
			400,
			team
		)

		GameInfo.fire_value[team] -= 1
		await get_tree().create_timer(time).timeout


func _on_shoot_timer_timeout() -> void:
	if !GameInfo.victory_value[team]:
		queue_free()
	if GameInfo.fire_value[team] > 0 and !GameInfo.has_winner:
		if GameInfo.fire_value[team] > 1000:
			emit_orb(15, 0.0075, 0.3)  # high speed = big spread
		elif GameInfo.fire_value[team] > 100:
			emit_orb(5, 0.02, 0.15)    # medium speed = moderate spread
		else:
			emit_orb(1, 0.1, 0.001)     # slow = minimal spread
