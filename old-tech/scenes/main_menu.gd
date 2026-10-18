extends Node2D

var main_scene = "res://scenes/main.tscn"

func _ready() -> void:
	pass

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file(main_scene)

func _on_music_scroll_value_changed(value: float) -> void:
	ProjectControls.setup_music(value)

func _on_sound_scroll_value_changed(value: float) -> void:
	ProjectControls.setup_sounds(value)
