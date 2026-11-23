extends Node2D

const SIDE_INSET := 84.0
const BOTTOM_INSET := 59.0

@onready var left: TouchScreenButton = $Left
@onready var right: TouchScreenButton = $Right


func _ready() -> void:
	setup_button(left, -1.0)
	setup_button(right, 1.0)
	get_viewport().size_changed.connect(layout_buttons)
	layout_buttons()


func layout_buttons() -> void:
	var size := get_viewport_rect().size
	left.position = Vector2(SIDE_INSET, size.y - BOTTOM_INSET)
	right.position = Vector2(size.x - SIDE_INSET, size.y - BOTTOM_INSET)


func setup_button(button: TouchScreenButton, direction: float) -> void:
	button.draw.connect(draw_button.bind(button, direction))
	button.pressed.connect(button.queue_redraw)
	button.released.connect(button.queue_redraw)


func draw_button(button: TouchScreenButton, direction: float) -> void:
	# The hit area extends upward, while the visible arrow stays below the player.
	var center := Vector2(0.0, 24.0)
	var fill := Color("#75678e") if button.is_pressed() else Color("#443b57")
	button.draw_circle(center, 19.0, fill, true, -1.0, true)
	var tip := center + Vector2(8.0 * direction, 0.0)
	var back := center + Vector2(-4.0 * direction, 0.0)
	button.draw_polyline(
		PackedVector2Array([back + Vector2(0, -8), tip, back + Vector2(0, 8)]),
		Color("#f4e8cc"), 4.0, true
	)
