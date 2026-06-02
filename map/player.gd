extends CharacterBody2D


var lanes = [-400, 0, 410]
var current = 1 
var is_jumping: bool = false
var jump_time: float = 0.0
@export var jump_duration: float = 0.6
@export var max_jump_scale: float = 1.3
@export var change_lane_speed: float = 15.0
@export var target_y_position: float = 0.0
@onready var anim: AnimatedSprite2D = $jump
var is_start: bool = false

func _ready():
	position = Vector2(lanes[current], target_y_position)
	if anim:
		anim.stop()
	
	

func _physics_process(delta: float) -> void:
	if not is_start:
		return
	velocity.y = 0
	position.y = target_y_position
	
	if Input.is_action_just_pressed("ui_left"):
		if current > 0:
			current -= 1
			
	
	if Input.is_action_just_pressed("ui_right"):
		if current < 2:
			current += 1
			

	position.x = lerp(position.x, float(lanes[current]), change_lane_speed * delta)
	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("key_space"):
		if not is_jumping:
			is_jumping = true
			jump_time = 0.0
			if anim:
				anim.play("default")
	if is_jumping:
		jump_time += delta
		if jump_time >= jump_duration:
			is_jumping = false
			scale = Vector2(1, 1) 
			if anim:
				anim.stop()	
		else:
			var progress = jump_time / jump_duration
			var height_factor = sin(progress * PI) 
			var current_scale = 1.0+(max_jump_scale - 1.0) * height_factor
			scale = Vector2(current_scale, current_scale)
			

	move_and_slide()
