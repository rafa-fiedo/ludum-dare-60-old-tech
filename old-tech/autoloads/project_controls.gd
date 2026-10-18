extends Node

func _unhandled_key_input(event):
	if event.is_action_pressed("reset"):
		reset_scene()
	if event.is_action_pressed("toggle_fullscreen"):
		toggle_fullscreen()
	
	if event.is_action_pressed("toggle_music"):
		toggle_music()
	if event.is_action_pressed("toggle_sounds"):
		toggle_sounds()

func toggle_fullscreen():
	var mode = DisplayServer.window_get_mode()
	var is_fullscreen = mode == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN or mode == DisplayServer.WINDOW_MODE_FULLSCREEN
	
	if is_fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func toggle_music():
	var bus_id = 1
	var is_mute = AudioServer.is_bus_mute(bus_id)
	AudioServer.set_bus_mute(bus_id, not is_mute)
	
func toggle_sounds():
	var bus_id = 2
	var is_mute = AudioServer.is_bus_mute(bus_id)
	AudioServer.set_bus_mute(bus_id, not is_mute)
	
func setup_music(value):
	var bus_id = 1
	setup_volume_by_bus_id_and_value(bus_id, value)

func setup_sounds(value):
	var bus_id = 2
	setup_volume_by_bus_id_and_value(bus_id, value)

func setup_volume_by_bus_id_and_value(bus_id, value):	
	if value <= 5:
		AudioServer.set_bus_mute(bus_id, true)
	else:
		AudioServer.set_bus_mute(bus_id, false)
		var volume_db := linear_to_db(value / 100.0)
		AudioServer.set_bus_volume_db(bus_id, volume_db)

func set_audio_master(is_on):
	AudioServer.set_bus_mute(0, not is_on)

func is_audio_master_on():
	return !AudioServer.is_bus_mute(0)

func reset_scene() -> void:
	get_tree().reload_current_scene()
