extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_button_pressed() -> void:
	var main_scene = get_tree().current_scene
	if main_scene and main_scene.has_method("trigger_game_start"):
		main_scene.trigger_game_start()
		
