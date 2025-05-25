extends Node

# Constants to identify teams
const TEAM_RED = 0
const TEAM_BLUE = 1

# Stores the current bank value for each team (starts at 1)
var bank_value = {
	TEAM_RED: 2,
	TEAM_BLUE: 2
}


# Stores the current bank value for each team (starts at 1)
var victory_value = {
	TEAM_RED: true,
	TEAM_BLUE: true
}


# Stores the current fire value for each team (starts at 0)
var fire_value = {
	TEAM_RED: 0,
	TEAM_BLUE: 0
}

func team_color(team):
	var color: Color;
	match team:
		0:
			color = Color(0, 0.75, 1.0)
		1:
			color = Color(1.0, 0, 0)
	return color;

# Optional: Reset function to use when restarting
func reset():
	bank_value[TEAM_RED] = 1
	bank_value[TEAM_BLUE] = 1
	fire_value[TEAM_RED] = 0
	fire_value[TEAM_BLUE] = 0
