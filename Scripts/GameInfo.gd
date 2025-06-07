extends Node

var has_winner := false

# Team Constants
const TEAM_RED       = 0
const TEAM_BLUE      = 1
const TEAM_GREEN     = 2
const TEAM_YELLOW    = 3
const TEAM_PURPLE    = 4
const TEAM_ORANGE    = 5
const TEAM_CYAN      = 6
const TEAM_PINK      = 7
const TEAM_WHITE     = 8
const TEAM_BLACK     = 9

var TEAMS = [
	TEAM_RED, TEAM_BLUE, TEAM_GREEN, TEAM_YELLOW, TEAM_PURPLE,
	TEAM_ORANGE, TEAM_CYAN, TEAM_PINK, TEAM_WHITE, TEAM_BLACK
]

# Unified Color Data
const TEAM_COLORS = {
	-1: {
		"primary": Color.BLACK,
		"box": Color.BLACK,
		"outline": Color.WHITE
	},
	TEAM_RED: {
		"primary": Color("ff4b4b"),
		"box": Color("ff9999"),
		"outline": Color("ff0000")
	},
	TEAM_BLUE: {
		"primary": Color("4b6aff"),
		"box": Color("99bbff"),
		"outline": Color(0,0,1)
	},
	TEAM_GREEN: {
		"primary": Color("4bff4b"),
		"box": Color("aaffaa"),
		"outline": Color(0,1,0) # green
	},
	TEAM_YELLOW: {
		"primary": Color("ffff4b"),
		"box": Color("ffffaa"),
		"outline": Color("ffff00") # change
	},
	TEAM_PURPLE: {
		"primary": Color("b84bff"),
		"box": Color("d199ff"),
		"outline":Color(90 * 2.5 / 255.0, 45 * 2.5 / 255.0, 128 * 2.5 / 255.0)
	},
	TEAM_ORANGE: {
		"primary": Color("ff994b"),
		"box": Color("ffcc99"),
		"outline": Color("a65326")
	},
	TEAM_CYAN: {
		"primary": Color("4bffff"),
		"box": Color("aaffff"),
		"outline": Color(.25,1.25,1.25) # change
	},
	TEAM_PINK: {
		"primary": Color("ff4bb8"),
		"box": Color("ffaadd"),
		"outline": Color("994b7d")
	},
	TEAM_WHITE: {
		"primary": Color("ffffff"),
		"box": Color("eeeeee"),
		"outline": Color("aaaaaa")
	},
	TEAM_BLACK: {
		"primary": Color("222222"),
		"box": Color("444444"),
		"outline": Color("000000")
	}
}

# Team state data
var bank_value = {}
var fire_value = {}
var victory_value = {}

func _ready():
	set_defult()

func team_color(team: int) -> Color:
	return TEAM_COLORS.get(team, TEAM_COLORS[-1])["primary"]

func team_box_color(team: int) -> Color:
	return TEAM_COLORS.get(team, TEAM_COLORS[-1])["box"]

func team_outline_color(team: int) -> Color:
	return TEAM_COLORS.get(team, TEAM_COLORS[-1])["outline"]

func set_defult():
	has_winner = false
	for team in TEAMS:
		bank_value[team] = 2
		fire_value[team] = 0
		victory_value[team] = true
