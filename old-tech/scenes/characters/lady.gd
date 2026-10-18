extends Node2D

var happy_sounds = [
	preload("res://assets/sounds/happy1.wav"),
	preload("res://assets/sounds/happy2.wav"),
	preload("res://assets/sounds/happy3.wav"),
	preload("res://assets/sounds/happy4.wav"), 
	preload("res://assets/sounds/happy5.wav"),
]

var normal_sounds = [
	preload("res://assets/sounds/normal1.wav"),
	preload("res://assets/sounds/normal2.wav"),
	preload("res://assets/sounds/normal3.wav"),
	preload("res://assets/sounds/normal4.wav"),
	preload("res://assets/sounds/normal5.wav"),
	preload("res://assets/sounds/normal6.wav"),
]

var sad_sounds = [
	preload("res://assets/sounds/sad1.wav"),
	preload("res://assets/sounds/sad2.wav"),
	preload("res://assets/sounds/sad3.wav"),
	preload("res://assets/sounds/sad4.wav"),
	preload("res://assets/sounds/sad5.wav"),
	preload("res://assets/sounds/sad6.wav"),
]

enum Face {HAPPY, NORMAL, SAD}
var current_face = Face.HAPPY


func use_face_happy() -> void:
	if current_face == Face.HAPPY:
		return
	
	turn_off_faces()
	$Sounds.stream = happy_sounds.pick_random()
	$Sounds.play()
	$Face/FaceHappy.visible = true
	current_face = Face.HAPPY

func use_face_normal() -> void:
	if current_face == Face.NORMAL:
		return
		
	turn_off_faces()
	$Sounds.stream = normal_sounds.pick_random()
	$Sounds.play()
	$Face/FaceNormal.visible = true
	current_face = Face.NORMAL
	
func use_face_sad() -> void:
	if current_face == Face.SAD:
		return
	turn_off_faces()
	$Sounds.stream = sad_sounds.pick_random()
	$Sounds.play()
	$Face/FaceSad.visible = true
	
	current_face = Face.SAD
	
func turn_off_faces() -> void:
	for child in $Face.get_children():
		child.visible = false
		
func start_animation():
	$AnimationPlayer.play("do")
	
func stop():
	$AnimationPlayer.stop()
