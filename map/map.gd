extends Node2D
@onready var score_label: Label = $CanvasLayer/score
@onready var parallax_map: Parallax2D = $maps
var whirlpool = preload("res://whirlpoll/whirlpool.tscn")
var obstacle_scene = preload("res://obstrucle/obstrucle.tscn")
var rock = preload("res://rocky/rocky.tscn")
var logg = preload("res://logs/log.tscn")
var lanes = [-400, 0, 410]
@onready var GG: Control = $"CanvasLayer/Game over and restart"
@onready var Start: Control =$"CanvasLayer/GameStart"
var speed: float = 200.0
var max_speed: float =800.0
@export var speed_increase_rate: float = 10.0
var score: float = 0.0
@export var base: float = 1.0
var is_GG: bool = false
var is_Start: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_Start:
		return
	if is_GG:
		return
	if speed < max_speed:
		speed += speed_increase_rate * delta
	if parallax_map:
		parallax_map.autoscroll.y= speed
	var score_multi = speed/ 200.0
	score += (base * score_multi)*delta
	if score_label:
		score_label.text = "score: " + str(int(score))
func _on_shark_timeout():
	if not is_Start:
		return
	var obstacle = [whirlpool, obstacle_scene, rock, logg]
	var random_obstacle = obstacle[randi() % obstacle.size()]
	if random_obstacle:
		var new_trap = random_obstacle.instantiate()
		var random_lane = randi() % 3
		new_trap.position.x = lanes[random_lane]
		new_trap.position.y = -200
		add_child(new_trap)
func trigger_game_start():
	if is_Start:
		return
	is_Start = true
	if Start:
		Start.hide()
	if parallax_map:
		parallax_map.autoscroll.y = 200
	if $player:
		$player.is_start = true
func trigger_game_over():
	if is_GG:
		return
	is_GG = true
	if parallax_map:
		parallax_map.autoscroll.y = 0
	if GG:
		GG.visible = true
		GG.show()
