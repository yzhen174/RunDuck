extends Node2D
@onready var score_label: Label = $CanvasLayer/score
@onready var parallax_map: Parallax2D = $maps

var obstacle_scene = preload("res://obstrucle/obstrucle.tscn")
var lanes = [-400, 0, 410]
@onready var GG: Control = $"CanvasLayer/Game over and restart"
@onready var Start: Control =$"CanvasLayer/GameStart"
var is_Start: bool = false
var speed: float = 200.0
var max: float =800.0
@export var speed_increase_rate: float = 10.0
var score: float = 0.0
@export var base: float = 1.0
var is_GG: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_Start:
		return
	if is_GG:
		return
	if speed < max:
		speed += speed_increase_rate * delta
	if parallax_map:
		parallax_map.autoscroll.y= speed
	var score_multi = speed/ 200.0
	score += (base * score_multi)*delta
	if score_label:
		score_label.text = "score: " + str(int(score))
func _on_timer_timeout():
	if not is_Start:
		return
	if obstacle_scene:
		var new_shark = obstacle_scene.instantiate()
		
		var random_lane_index = randi() % 3
		new_shark.position.x =lanes[random_lane_index]
		new_shark.position.y = -200
		if parallax_map:
			parallax_map.add_child(new_shark)
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
