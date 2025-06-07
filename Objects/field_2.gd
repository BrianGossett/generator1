extends Node2D

var box_rows: Array = []

func _ready():
	# Auto-populate rows if not already assigned
	box_rows = get_children()

# Expects a 32x40 array of dictionaries like:
# settings[row][col] = { "team": 1, "victory": true }
func apply_box_grid(settings: Array):
	for row in range(min(box_rows.size(), settings.size())):
		var row_node = box_rows[row]
		var row_settings = settings[row]
		var box_nodes = row_node.get_children()

		for col in range(min(box_nodes.size(), row_settings.size())):
			var box = box_nodes[col]
			var config = row_settings[col]

			if box.has_method("set_team") and config.has("team"):
				box.set_team(config["team"])

			if box.has_method("set_victory") and config.has("victory"):
				box.set_victory(config["victory"])
				
func generate_grid_from_zones(teams: Dictionary) -> Array:
	var grid = []

	for row in range(34):  # 34 rows total
		var row_data = []
		for col in range(40):
			var team = -1
			var victory := false

			# Determine zone (flipped logic: row 0 = bottom)
			var row_zone: String
			if row <= 10:
				row_zone = "bot"
			elif row <= 22:
				row_zone = "mid"
			else:
				row_zone = "top"

			var col_zone = "left" if col < 20 else "right"
			var zone_key = row_zone + "_" + col_zone
			team = teams.get(zone_key, -1)

			# Middle three rows for each zone
			var victory_rows = {
				"bot": [5, 6, 7],
				"mid": [16, 17, 18],
				"top": [27, 28, 29],
			}

			var is_left_victory_col = col in [1, 2, 3]
			var is_right_victory_col = col in [36, 37, 38]
			var is_victory_row = row in victory_rows[row_zone]

			if is_victory_row and (
				(col_zone == "left" and is_left_victory_col) or
				(col_zone == "right" and is_right_victory_col)
			):
				victory = true

			row_data.append({
				"team": team,
				"victory": victory
			})
		grid.append(row_data)

	return grid
