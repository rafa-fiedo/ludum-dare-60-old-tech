extends Node2D

func _ready() -> void:
	start_timer()

func _physics_process(delta: float) -> void:
	print($ActionBar.get_is_mouse_inside())

func start_timer() -> void:
	$Timer.start(10)
