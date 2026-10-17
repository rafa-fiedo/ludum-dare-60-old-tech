extends Node2D

var vec_mouse_y: float = 0.0
var mouse_border_margin_px: int = 40
var button_border_margin_px: int = 150

var min_position_y: float = -9999
var max_position_y: float = 9999

var is_mouse_inside = false

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	setup_positions()
	setup_is_mouse_inside()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		vec_mouse_y = event.relative.y

func _process(_delta: float) -> void:
	move_mouse()
	setup_is_mouse_inside()

func setup_positions() -> void:
	min_position_y = $Top.global_position.y + mouse_border_margin_px
	max_position_y = $Bottom.global_position.y - mouse_border_margin_px

func move_mouse() -> void:
	var new_position = $Mouse.global_position.y + vec_mouse_y
	$Mouse.global_position.y = new_position
	$Mouse.global_position.y = clamp(new_position, min_position_y, max_position_y)
	
	vec_mouse_y = 0
	
func setup_is_mouse_inside() -> void:
	is_mouse_inside = calculate_is_mouse_inside()
	
func calculate_is_mouse_inside() -> bool:
	var button_top = $Button/BottomButton.global_position.y
	var button_bottom = $Button/TopButton.global_position.y
	
	var is_top_inside = is_between($Mouse/TopMouse.global_position.y, button_bottom ,button_top)
	var is_bottom_inside = is_between($Mouse/BottomMouse.global_position.y, button_bottom ,button_top)
	
	return is_top_inside && is_bottom_inside
		
func is_between(value: float, x: float, y: float) -> bool:
	return value >= x and value <= y
	
func get_is_mouse_inside():
	return is_mouse_inside
