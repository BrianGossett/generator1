extends Node2D
@export var scroll_speed: float = 30.0
@export var scroll_height: float = 500.0 
@export var row_spacing: float = 60   
@export var row_height: float = 20.0    

@onready var even_row: PackedScene = preload("res://Objects/even_row.tscn")
@onready var odd_row: PackedScene = preload("res://Objects/odd_row.tscn")
@onready var spawn_point := $"SpawnPoint"

var last_row_is_even := false

func _ready():
	spawn_point.position.y = -scroll_height;
	# Fill visible area with rows bottom to top
	var y := 0.0
	while y < scroll_height:
		var row = spawn_row()
		row.position.y = scroll_height - y
		add_child(row)
		y += row_height + row_spacing

func _process(delta: float) -> void:
	var rows_to_remove = []

	for row in get_children():
		if not row is Node2D:
			continue

		row.position.y -= scroll_speed * delta

		if row.position.y + row_height < 0:
			rows_to_remove.append(row)

	for row in rows_to_remove:
		row.queue_free()
		_add_new_row_to_bottom()

func _add_new_row_to_bottom():
	var row = spawn_row()

	# Find current lowest row
	var min_y := 0.0
	for child in get_children():
		if child is Node2D:
			min_y = max(min_y, child.position.y)

	row.position.y = min_y + row_height + row_spacing
	add_child(row)

func spawn_row() -> Node2D:
	last_row_is_even = !last_row_is_even
	var scene = even_row if last_row_is_even else odd_row
	return scene.instantiate()
