extends Node2D

var vec_mouse_y: float = 0.0
var is_working = true

var button_speed: float = 10.0
var button_direction = 0 # 0 is init
var min_button_scale = 0.2

const START_TIMER = 20
const UP_DIFF_TIMER = 5

var min_mouse_position_y: float = -9999
var max_mouse_position_y: float = 9999
var min_button_position_y: float = -9999
var max_button_position_y: float = 9999

var is_mouse_inside = false

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	setup_positions()
	setup_is_mouse_inside()
	
func start_button():
	setup_button_direction()
	$AddDifficultyTimer.start(START_TIMER)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		vec_mouse_y = event.relative.y

func _process(_delta: float) -> void:
	if not is_working:
		return
	move_mouse()
	
func _physics_process(_delta: float) -> void:
	move_button()
	setup_is_mouse_inside()

func setup_positions() -> void:
	var mouse_border_margin_px = ($Mouse/BottomMouse.global_position.y - $Mouse/TopMouse.global_position.y) / 2.0
	var button_border_margin_px = ($Button/BottomButton.global_position.y - $Button/TopButton.global_position.y) / 2.0
	
	min_mouse_position_y = $Top.global_position.y + mouse_border_margin_px
	max_mouse_position_y = $Bottom.global_position.y - mouse_border_margin_px
	
	min_button_position_y = $Top.global_position.y + button_border_margin_px
	max_button_position_y = $Bottom.global_position.y - button_border_margin_px

func move_mouse() -> void:
	var new_position = $Mouse.global_position.y + vec_mouse_y
	$Mouse.global_position.y = new_position
	$Mouse.global_position.y = clamp(new_position, min_mouse_position_y, max_mouse_position_y)
	
	vec_mouse_y = 0
	
func move_button() -> void:
	var move_y = button_speed * button_direction
	
	var new_position = $Button.global_position.y + move_y
	$Button.global_position.y = new_position
	$Button.global_position.y = clamp(new_position, min_button_position_y, max_button_position_y)
	
func setup_is_mouse_inside() -> void:
	is_mouse_inside = calculate_is_mouse_inside()
	
func calculate_is_mouse_inside() -> bool:
	var button_top = $Button/BottomButton.global_position.y
	var button_bottom = $Button/TopButton.global_position.y
	
	return is_between($Mouse.global_position.y, button_bottom ,button_top)
		
func is_between(value: float, x: float, y: float) -> bool:
	return value >= x and value <= y
	
func get_is_mouse_inside():
	return is_mouse_inside

func setup_button_direction():
	if get_random_bool():
		button_direction = 1
	else:
		button_direction = -1
		
	$ButtonTimer.start(randf_range(0.2, 0.8))

func _on_button_timer_timeout() -> void:
	setup_button_direction()
	
func get_random_bool() -> bool:
	return randi() % 2

func stop_game():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$ButtonTimer.stop()
	$AddDifficultyTimer.stop()
	is_working = false

func _on_add_difficulty_timer_timeout() -> void:
	raise_difficulty()
	$AddDifficultyTimer.start(UP_DIFF_TIMER)
	
func raise_difficulty():
	button_speed *= 1.1
	$Button.scale.y = max(min_button_scale, $Button.scale.y * 0.90)
	setup_positions()
