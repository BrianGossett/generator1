extends Node2D

@export var max_x2_height := 200
@export var max_release_height := 200

@export var min_x: float = 85
@export var max_x: float = 200.0
@export var transition_speed := .1  # Units per second

@onready var zone_x2 := $ZoneX2
@onready var zone_release := $ZoneRelease
@onready var chaos_circle := $WallBody/ChaosCircle
@onready var wall_body := $WallBody

signal score_zone_triggered(zone_name: String, body: Node)


var zone_x2_start_x: float
var zone_release_end_x: float

func _ready() -> void:
	zone_x2_start_x = zone_x2.position.x
	zone_release_end_x = zone_release.position.x + zone_release.get_child(1).size.x
	wall_body.position.x = min_x
	zone_x2.connect("body_entered", _on_body_entered.bind("ZoneX2"))
	zone_release.connect("body_entered", _on_body_entered.bind("ZoneRelease"))
	


func _on_body_entered(body: Node, zone_name: String):
	emit_signal("score_zone_triggered", zone_name, body)


func _process(delta: float) -> void:
	# Move wall body
	wall_body.position.x = clamp(wall_body.position.x + transition_speed * delta, min_x, max_x)

	# Attach chaos circle to wall (with offset if needed)
	chaos_circle.position = Vector2(10, 0)

	# Calculate distances
	var wall_offset = wall_body.position.x
	zone_x2.position.x = zone_x2_start_x
	var x2_width = wall_body.position.x - zone_x2.position.x

	var release_width = zone_release_end_x - wall_body.position.x - wall_body.get_child(1).size.x
	zone_release.position.x = wall_body.position.x + wall_body.get_child(1).size.x

	# --- Resize ZoneX2 ---
	var x2_collision = zone_x2.get_node("Score1Collision")
	var x2_shape = x2_collision.shape
	x2_collision.position.x = x2_width / 2
	x2_shape.size.x = x2_width

	var x2_visual = zone_x2.get_node("ColorRect")
	x2_visual.size.x = x2_shape.size.x

	var x2_label = zone_x2.get_node("Label")
	x2_label.position.x = x2_shape.size.x / 2.0 - x2_label.size.x / 2.0

	# --- Resize ZoneRelease ---
	var release_collision = zone_release.get_node("Score1Collision")
	var release_shape = release_collision.shape
	release_collision.position.x = release_width/2
	release_shape.size.x = release_width

	var release_visual = zone_release.get_node("ColorRect")
	release_visual.size.x = release_shape.size.x

	var release_label = zone_release.get_node("Label")
	release_label.position.x = release_shape.size.x / 2.0 - release_label.size.x / 2.0

	# Rotate chaos logo
	chaos_circle.rotation += delta * PI * .25
