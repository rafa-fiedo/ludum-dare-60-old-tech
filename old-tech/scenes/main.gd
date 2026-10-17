extends Node2D

var check_count: float = 0
var in_checks_count: float = 0
var percent_store = 1

var score_happy: float = 0.8
var score_normal: float = 0.6

func _ready() -> void:
	start_timer()
	$Time.text = ""
	$Percent.text = ""

func _physics_process(_delta: float) -> void:
	update_lady_face()
	update_debug_texts()

func start_timer() -> void:
	$GameTime.start(10)
	$CheckTimer.start(0.2)

func update_lady_face() -> void:
	if percent_store > score_happy:
		$Lady.use_face_happy()
		return
	if percent_store > score_normal:
		$Lady.use_face_normal()
		return
	
	$Lady.use_face_sad()
	

func _on_game_time_timeout() -> void:
	$CheckTimer.stop()
	
func _on_check_timer_timeout() -> void:
	check_count += 1
	if $ActionBar.get_is_mouse_inside():
		in_checks_count += 1
	percent_store = in_checks_count / check_count
	
func update_debug_texts() -> void:
	$Time.text = "%.2f" % $GameTime.time_left
	$Percent.text = "%.2f" % (percent_store * 100) + "%"
	
func round_to_2(value: float) -> float:
	return round(value * 100.0) / 100.0
