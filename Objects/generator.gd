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

func _process(_delta: float) -> void:
	updateLables()


#func _on_zone_x2_triggered(body: Node) -> void:
func _on_score_1_body_entered(body: Node2D) -> void:
	zone_x2(body)

func zone_x2(body: Node2D):
	if(body.get_groups().has("Ball")):
		GameInfo.bank_value[team] *= 2
		updateLables()
		body.queue_free()
		call_deferred("BallSpawn", 1)

#func _on_zone_release_triggered(body: Node) -> void:
func _on_score_2_body_entered(body: Node2D) -> void:
	zone_release(body)
	
func zone_release(body: Node2D):
	if(body.get_groups().has("Ball")):
		GameInfo.fire_value[team] += GameInfo.bank_value[team]
		GameInfo.bank_value[team] = 2
		updateLables()
		body.queue_free()
		call_deferred("BallSpawn", 1)


func BallSpawn(number):
	for i in range(number):
		var spawn_x = randf_range(min_x, max_x)
		var spawn_y = randf_range(min_y, max_y)
		var ball = ballSpawner.instantiate()
		bank.add_theme_color_override('font_color',GameInfo.team_color(team));
		ball.position = Vector2(spawn_x, spawn_y)
		ball.configure(team,1,.2);
		add_child(ball)


func updateLables():
	bank.text = str(GameInfo.bank_value[team])
	fireValue.text = str(GameInfo.fire_value[team])


func _on_ball_catcher_score_zone_triggered(zone_name: String, body: Node) -> void:
	if zone_name == 'ZoneRelease':
		zone_release(body)
	if zone_name == 'ZoneX2':
		zone_x2(body)
