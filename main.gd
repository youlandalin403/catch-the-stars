
extends Node2D

const STAR_SCENE = preload("res://star.tscn")

enum GameState {
	MENU,
	PLAYING,
	GAME_OVER
}

var state = GameState.MENU
var score: int = 0

@onready var player = $Player
@onready var player_start: Vector2 = $Player.position

@onready var status_label = $HUD/StatusLabel
@onready var menu = $HUD/Menu
@onready var menu_box = $HUD/Menu/MenuBox
@onready var message = $HUD/Menu/MenuBox/MessageLabel
@onready var action_button = $HUD/Menu/MenuBox/ActionButton
@onready var touch_controls = $HUD/TouchControls


# 1. 初始化
func _ready():
	$StarTimer.timeout.connect(spawn_star)
	$GameTimer.timeout.connect(game_over)
	action_button.pressed.connect(start_game)

	setup_ui()

	show_menu()

	if not OS.has_feature("web"):
		$BGM.play()


# 2. 设置界面样式
func setup_ui():
	status_label.position = Vector2(16, 16)
	status_label.add_theme_font_size_override("font_size", 24)

	menu.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	menu_box.add_theme_constant_override("separation", 20)

	message.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	message.add_theme_font_size_override("font_size", 36)

	action_button.custom_minimum_size = Vector2(240, 48)
	action_button.add_theme_font_size_override("font_size", 24)


# 3. 显示初始菜单
func show_menu():
	state = GameState.MENU

	$StarTimer.stop()
	$GameTimer.stop()

	player.set_physics_process(false)
	player.hide()
	status_label.hide()

	message.text = "Catch the Stars"
	action_button.text = "Start Game"
	touch_controls.hide()

	menu.show()


# 4. 开始或重新开始游戏
func start_game():
	if state == GameState.PLAYING:
		return

	state = GameState.PLAYING
	score = 0

	clear_stars()

	player.position = player_start
	player.velocity = Vector2.ZERO
	player.show()
	player.set_physics_process(true)

	menu.hide()
	status_label.show()
	touch_controls.visible = DisplayServer.is_touchscreen_available()

	$StarTimer.start()
	$GameTimer.start()

	update_hud()

	# 浏览器在玩家第一次操作后才允许播放音频。
	if not $BGM.playing:
		$BGM.play()
	$ButtonSound.play()


# 5. 每帧更新界面
func _process(_delta):
	if state == GameState.PLAYING:
		update_hud()


# 6. 生成星星
func spawn_star():
	if state != GameState.PLAYING:
		return

	var star = STAR_SCENE.instantiate()

	var screen_width = get_viewport_rect().size.x

	star.position.x = randf_range(24, screen_width - 24)
	star.position.y = -30

	star.collected.connect(_on_star_collected)

	$Stars.add_child(star)


# 7. 增加分数

func _on_star_collected(points: int, at_position: Vector2):
	if state != GameState.PLAYING:
		return

	score += points
	spawn_collect_fx(at_position)

	$CollectSound.play()



# 8. 更新游戏信息
func update_hud():
	var seconds = ceili($GameTimer.time_left)

	status_label.text = (
		"Score: " + str(score)
		+ "\nTime: " + str(seconds)
	)


# 9. 清理星星
func clear_stars():
	for star in $Stars.get_children():
		star.queue_free()


# 10. 游戏结束
func game_over():
	if state != GameState.PLAYING:
		return

	state = GameState.GAME_OVER

	$StarTimer.stop()
	$GameTimer.stop()
	$GameOverSound.play()

	player.set_physics_process(false)
	player.hide()

	clear_stars()

	status_label.hide()

	message.text = "Game Over!\nFinal Score: " + str(score)
	action_button.text = "Play Again"
	touch_controls.hide()

	menu.show()




func spawn_collect_fx(at_position: Vector2):
	var fx = CPUParticles2D.new()

	fx.emitting = false
	fx.one_shot = true
	fx.amount = 12
	fx.lifetime = 0.45
	fx.explosiveness = 1.0

	fx.direction = Vector2.UP
	fx.spread = 180.0
	fx.gravity = Vector2.ZERO

	fx.initial_velocity_min = 65.0
	fx.initial_velocity_max = 120.0

	fx.texture = preload("res://star.svg")
	fx.scale_amount_min = 0.10
	fx.scale_amount_max = 0.18

	$Stars.add_child(fx)
	fx.global_position = at_position

	fx.finished.connect(fx.queue_free)
	fx.emitting = true
