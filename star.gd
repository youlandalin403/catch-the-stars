
extends Area2D

signal collected(points: int, at_position: Vector2)

@export var fall_speed: float = 150.0
@export var point_value: int = 1

func _ready():
	body_entered.connect(_on_body_entered)

func _physics_process(delta):
	position.y += fall_speed * delta

	var screen_height = get_viewport_rect().size.y

	if position.y > screen_height + 30:
		queue_free()

func _on_body_entered(body):
	if body is CharacterBody2D and not is_queued_for_deletion():
		collected.emit(point_value, global_position)
		queue_free()
