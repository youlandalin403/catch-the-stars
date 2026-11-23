
extends CharacterBody2D

@export var speed: float = 300.0
const HALF_WIDTH = 32.0

func _ready():
	motion_mode = MOTION_MODE_FLOATING

func _physics_process(_delta):
	var direction = Input.get_axis("ui_left", "ui_right")

	velocity.x = direction * speed
	move_and_slide()

	var screen_width = get_viewport_rect().size.x

	position.x = clamp(
		position.x,
		HALF_WIDTH,
		screen_width - HALF_WIDTH
	)
