extends Node2D

func _unhandled_key_input(event):
	if event.is_action_pressed("pause"):
		toggle_pause()

func toggle_pause() -> void:
	var new_pause = !get_tree().paused
	get_tree().paused = new_pause
	
	if new_pause:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
