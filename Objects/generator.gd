extends Node2D


@onready var ballTopLeft = $BallSpawnerTopLeft
@onready var ballBottomRight = $BallSpawnerBottomRight
@onready var bank = $Values 
@onready var fireValue = $ReleaseValue

@export var team: int = 0;

var ballSpawner = preload("res://Objects/ball.tscn")


var min_x
var max_x
var min_y
var max_y

func _ready():
	min_x = ballTopLeft.position.x
	max_x = ballBottomRight.position.x
	min_y = ballBottomRight.position.y
	max_y = ballTopLeft.position.y
	BallSpawn()
	BallSpawn()
	BallSpawn()
	BallSpawn()
	BallSpawn()
	BallSpawn()

func BallSpawn():
	var spawn_x = randf_range(min_x, max_x)
	var spawn_y = randf_range(min_y, max_y)
	var ball = ballSpawner.instantiate()
	bank.add_theme_color_override('font_color',GameInfo.team_color(team));
	ball.position = Vector2(spawn_x, spawn_y)
	ball.configure(team,1,.2);
	add_child(ball)

func _on_score_1_body_entered(body: Node2D) -> void:
	if(body.get_groups().has("Ball")):
		GameInfo.bank_value[team] *= 2
		updateLables()
		body.queue_free()
		BallSpawn()


func _on_score_2_body_entered(body: Node2D) -> void:
	if(body.get_groups().has("Ball")):
		GameInfo.fire_value[team] += GameInfo.bank_value[team]
		GameInfo.bank_value[team] = 1
		updateLables()
		body.queue_free()
		BallSpawn()
		
func updateLables():
	bank.text = str(GameInfo.bank_value[team])
	fireValue.text = str(GameInfo.fire_value[team])
