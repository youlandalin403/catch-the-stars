
extends Node2D

const SKY_TOP = Color("#171A32")
const SKY_BOTTOM = Color("#62567F")
const STAR_COLOR = Color("#F4E8CC")

func _ready():
	z_index = -10
	queue_redraw()


func _draw():
	var size = get_viewport_rect().size
	var w = size.x
	var h = size.y

	# 1. 天空渐变
	for y in range(0, int(h), 8):
		var t = float(y) / h
		var color = SKY_TOP.lerp(SKY_BOTTOM, t)

		draw_rect(
			Rect2(0, y, w, 8),
			color
		)

	# 2. 月亮
	draw_circle(
		Vector2(w * 0.8, h * 0.18),
		43,
		STAR_COLOR
	)

	# 3. 随机分布的小星点
	var rng = RandomNumberGenerator.new()
	rng.seed = 2026

	for i in range(100):
		var x = rng.randf_range(0, w)
		var y = rng.randf_range(0, h * 0.78)
		var radius = rng.randf_range(1, 2.5)

		draw_circle(
			Vector2(x, y),
			radius,
			STAR_COLOR
		)

	# 4. 远山
	var mountains = PackedVector2Array([
		Vector2(0, h * 0.86),
		Vector2(w * 0.15, h * 0.60),
		Vector2(w * 0.30, h * 0.83),
		Vector2(w * 0.48, h * 0.57),
		Vector2(w * 0.70, h * 0.84),
		Vector2(w * 0.88, h * 0.65),
		Vector2(w, h * 0.83),
		Vector2(w, h),
		Vector2(0, h)
	])

	draw_colored_polygon(
		mountains,
		Color("#343853")
	)

	# 5. 近处的地面
	draw_rect(
		Rect2(0, h - 45, w, 45),
		Color("#202A3D")
	)
