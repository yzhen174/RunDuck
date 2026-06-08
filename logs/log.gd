extends Area2D
@onready var logs: Sprite2D = $log
var speed: float = 400.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += speed*delta
	if position.y >1000:
		queue_free()
func _on_body_entered(body: Node2D) -> void:	
	if body.name == "player":
		if "is_jumping" in body and body.is_jumping == true:
			return
		if body.has_method("hide"):
			body.hide()
			await get_tree().create_timer(0.1).timeout
		var main_map = get_tree().current_scene
		if main_map and main_map.has_method("trigger_game_over"):
			main_map.trigger_game_over() 
