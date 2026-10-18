extends Node2D

var checks: Array = []
var percent_store = 1

var game_timer = 0
var time_update = 0.5

# 100 check and 0.1 check time -> 10sec
var max_checks = 50
var min_checks = 25
var check_time = 0.1

var score_happy: float = 0.8
var score_normal: float = 0.6
var score_lose: float = 0.4

var is_working = true

func _ready() -> void:
	randomize()
	$StartTimer.play("PrepareStart")
	$StartTimer/StartTimer.start(3)
	$ScoreMenu.visible = false

func _physics_process(_delta: float) -> void:
	if not is_working:
		return 
	update_lady_face()
	update_debug_texts()

func start_main_timer() -> void:
	$GameTime.start(time_update)
	$CheckTimer.start(check_time)
	$ActionBar.start_button()

func update_lady_face() -> void:
	if checks.size() < min_checks:
		return
		
	if percent_store > score_happy:
		$Lady.use_face_happy()
		return
	if percent_store > score_normal:
		$Lady.use_face_normal()
		return
	
	$Lady.use_face_sad()
	
	if percent_store < score_lose:
		is_working = false
		stop_game()

func _on_game_time_timeout() -> void:
	game_timer += $GameTime.wait_time
	$Time.text = "%.1f" % game_timer
	
func stop_game():
	is_working = false
	$ScoreMenu.visible = true
	$ActionBar.stop_game()
	$GameTime.stop()
	$CheckTimer.stop()
	$StartTimer/StartTimer.stop()
	$Music.stop()
	
func _on_check_timer_timeout() -> void:
	var is_inside = $ActionBar.get_is_mouse_inside()
	checks.append(is_inside)
	
	if checks.size() > max_checks:
		checks.pop_front()
		
	update_percents()
	
func update_percents():
	var true_count = 0
	
	for is_true in checks:
		if is_true:
			true_count += 1
	
	percent_store = float(true_count) / checks.size()
	
func update_debug_texts() -> void:
	$Percent.text = "%.2f" % (percent_store * 100) + "%"

func _on_start_timer_timeout() -> void:
	start_main_timer()
	$Music.play()
	$Time.text = "0.0"
	$Percent.text = ""
	
func round_to_2(value: float) -> float:
	return round(value * 100.0) / 100.0


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_again_pressed() -> void:
	get_tree().reload_current_scene()
