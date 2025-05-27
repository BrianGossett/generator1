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
				

func generate_grid_from_corners(teams) -> Array:
	var grid = []

	for row in range(32):
		var row_data = []
		for col in range(40):
			var team = -1
			var victory := false

			if row < 16 and col < 20:
				team = teams.get("bottom_left", -1)
			elif row < 16 and col >= 20:
				team = teams.get("bottom_right", -1)
			elif row >= 16 and col < 20:
				team = teams.get("top_left", -1)
			else:
				team = teams.get("top_right", -1)
			
			if (row < 3 and col < 3) or (row < 3 and col >= 37) or (row >= 29 and col < 3) or (row >= 29 and col >= 37):
				if team != -1:
					victory = true

			row_data.append({
				"team": team,
				"victory": victory
			})
		grid.append(row_data)

	return grid
