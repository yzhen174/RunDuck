extends Area2D

@onready var shark: AnimatedSprite2D = $shark
var speed: float = 200.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if shark:
		shark.play("swim")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += speed*delta
	if position.y >1000:
		queue_free()
	
		
		
func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		if shark:
			shark.play("default")
	if body.has_method("hide"):
		body.hide()
	await get_tree().create_timer(0.4).timeout
	var main_map = get_tree().current_scene
	if main_map and main_map.has_method("trigger_game_over"):
		main_map.trigger_game_over() 
			
